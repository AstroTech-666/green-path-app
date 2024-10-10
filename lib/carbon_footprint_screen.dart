import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart'; // Import for pie chart

class CarbonFootprintScreen extends StatefulWidget {
  const CarbonFootprintScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarbonFootprintScreenState createState() => _CarbonFootprintScreenState();
}

class _CarbonFootprintScreenState extends State<CarbonFootprintScreen> {
  final TextEditingController electricityController = TextEditingController();
  final TextEditingController privateVehiclesController = TextEditingController();
  final TextEditingController publicTransportController = TextEditingController();
  final TextEditingController flightsController = TextEditingController();
  final TextEditingController foodController = TextEditingController();
  final TextEditingController expenditureController = TextEditingController();
  final TextEditingController otherCO2Controller = TextEditingController();

  double totalFootprint = 0.0;
  List<String> previousFootprints = [];
  
  double electricityFootprint = 0.0;
  double privateVehiclesFootprint = 0.0;
  double publicTransportFootprint = 0.0;
  double flightsFootprint = 0.0;
  double foodFootprint = 0.0;
  double expenditureFootprint = 0.0;

  @override
  void initState() {
    super.initState();
    loadPreviousFootprints();
  }

  void loadPreviousFootprints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      previousFootprints = prefs.getStringList('footprints') ?? [];
    });
  }

  void saveFootprint(String footprint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    previousFootprints.add(footprint);
    await prefs.setStringList('footprints', previousFootprints);
  }

  void calculateFootprint() {
    electricityFootprint = (double.tryParse(electricityController.text) ?? 0) * 0.233; // kg CO2 per kWh
    privateVehiclesFootprint = (double.tryParse(privateVehiclesController.text) ?? 0) * 0.21; // kg CO2 per km
    publicTransportFootprint = (double.tryParse(publicTransportController.text) ?? 0) * 0.15; // kg CO2 per km
    flightsFootprint = (double.tryParse(flightsController.text) ?? 0) * 0.25; // kg CO2 per km
    foodFootprint = (double.tryParse(foodController.text) ?? 0) * 0.1; // kg CO2 per kg of food
    expenditureFootprint = (double.tryParse(expenditureController.text) ?? 0) * 0.05; // kg CO2 per dollar spent
    double otherCO2 = double.tryParse(otherCO2Controller.text) ?? 0; // Direct input for other sources

    setState(() {
      totalFootprint = electricityFootprint +
          privateVehiclesFootprint +
          publicTransportFootprint +
          flightsFootprint +
          foodFootprint +
          expenditureFootprint +
          otherCO2;

      String result = 'Total: ${totalFootprint.toStringAsFixed(2)} kg CO2';
      saveFootprint(result);
    });
  }

  String generateFeedback() {
    if (totalFootprint < 100) {
      return "Great job! Your carbon footprint is quite low.";
    } else if (totalFootprint < 250) {
      return "Your carbon footprint is moderate. Consider reducing it further.";
    } else {
      return "Your carbon footprint is high. Here are some tips to reduce it:\n"
             "- Use public transport more often.\n"
             "- Reduce electricity usage at home.\n"
             "- Consider carpooling or using electric vehicles.\n"
             "- Opt for plant-based diets when possible.\n"
             "- Reduce unnecessary air travel.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint Calculator'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calculate Your Carbon Footprint',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInputField(
                'Home Electricity Usage (kWh)',
                electricityController,
                'Enter electricity usage...',
                Icons.electric_bolt),
            _buildInputField('Private Vehicles (km)', privateVehiclesController,
                'Distance driven...', Icons.directions_car),
            _buildInputField('Public Transport (km)', publicTransportController,
                'Distance traveled...', Icons.bus_alert),
            _buildInputField('Flights (km)', flightsController,
                'Distance flown...', Icons.flight),
            _buildInputField('Food Consumption (kg)', foodController,
                'Food consumed...', Icons.fastfood),
            _buildInputField('Expenditure (\$)', expenditureController,
                'Money spent...', Icons.money),
            _buildInputField('Other CO2 Sources', otherCO2Controller,
                'Additional CO2 sources...', Icons.assessment),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                calculateFootprint();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Feedback'),
                    content: Text(generateFeedback()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 33, 116, 58),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Calculate Carbon Footprint',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            _buildFootprintResult(),
            const SizedBox(height: 20),
            _buildPreviousFootprints(),
            const SizedBox(height: 20),

            // Pie Chart Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0), // Added padding for separation
              child: Text(
                'Your Carbon Footprint Breakdown',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: showingSections(),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(6, (i) {
      final double total = electricityFootprint + privateVehiclesFootprint + publicTransportFootprint + flightsFootprint + foodFootprint + expenditureFootprint;
      final double percentage = total > 0 ? (i == 0 ? electricityFootprint : (i == 1 ? privateVehiclesFootprint : (i == 2 ? publicTransportFootprint : (i == 3 ? flightsFootprint : (i == 4 ? foodFootprint : expenditureFootprint))))) / total * 100 : 0;
      final String label = '${percentage.toStringAsFixed(1)}%';
      const double fontSize = 16;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: electricityFootprint,
            title: label,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: privateVehiclesFootprint,
            title: label,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.orange,
            value: publicTransportFootprint,
            title: label,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red,
            value: flightsFootprint,
            title: label,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.purple,
            value: foodFootprint,
            title: label,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.brown,
            value: expenditureFootprint,
            title: label,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildInputField(String label, TextEditingController controller,
      String hint, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.green[800]),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFootprintResult() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Your Total Footprint: ${totalFootprint.toStringAsFixed(2)} kg CO2',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildPreviousFootprints() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Previous Calculations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: previousFootprints.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(previousFootprints[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
