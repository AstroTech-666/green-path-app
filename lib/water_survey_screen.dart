import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class WaterSurveyScreen extends StatefulWidget {
  const WaterSurveyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WaterSurveyScreenState createState() => _WaterSurveyScreenState();
}

class _WaterSurveyScreenState extends State<WaterSurveyScreen> {
  // Variables for the survey inputs
  int _householdMembers = 1;
  int _showerDuration = 5;
  bool _hasLowFlowShower = false;
  double _kitchenFaucetTime = 5;
  bool _usesLowFlowKitchenSink = false;
  int _laundryPerWeek = 1;
  bool _hasGarden = false;
  double _gardenWaterUsage = 10.0;
  int _wateringFrequency = 1;
  double _totalWaterUsage = 0.0;
  
  // Variables for storing results
  List<String> previousResults = [];
  int _points = 0;
  List<double> _usageHistory = [];

  @override
  void initState() {
    super.initState();
    loadPreviousResults(); // Load previous results on initialization
  }

  // Method to load previous results from SharedPreferences
  Future<void> loadPreviousResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      previousResults = prefs.getStringList('waterResults') ?? [];
      _usageHistory = prefs
              .getStringList('usageHistory')
              ?.map((e) => double.parse(e))
              .toList() ?? [];
    });
  }

  // Method to save the latest water usage result to SharedPreferences
  Future<void> saveResult(String result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    previousResults.add(result);
    await prefs.setStringList('waterResults', previousResults);
  }

  // Method to save water usage history to SharedPreferences
  Future<void> saveUsageHistory(double usage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _usageHistory.add(usage);
    await prefs.setStringList(
        'usageHistory', _usageHistory.map((e) => e.toString()).toList());
  }

  // Method to calculate total water usage based on input
  void _calculateTotalUsage() {
    double showerMultiplier = _hasLowFlowShower ? 7 : 15;
    double kitchenSinkMultiplier = _usesLowFlowKitchenSink ? 0.5 : 1;

    _totalWaterUsage =
        (_showerDuration * _householdMembers * showerMultiplier) +
            (_kitchenFaucetTime * kitchenSinkMultiplier) +
            (_laundryPerWeek * 10) +
            (_gardenWaterUsage * (_hasGarden ? 1 : 0)) +
            (_wateringFrequency * 5);

    saveUsageHistory(_totalWaterUsage); // Save calculated usage history
  }

  // Method to get usage category
  String _getUsageCategory() {
    if (_totalWaterUsage < 100) {
      return 'low';
    } else if (_totalWaterUsage <= 200) {
      return 'average';
    } else {
      return 'high';
    }
  }

  // Method to provide feedback based on usage
  String _getUsageFeedback() {
    String category = _getUsageCategory();
    if (category == 'low') {
      return 'Great job! Your water usage is low.';
    } else if (category == 'average') {
      return 'Your water usage is average.';
    } else {
      return 'Your water usage is high.';
    }
  }

  // Method to handle form submission and display results
  Future<void> _submitResults() async {
    _calculateTotalUsage();
    String result =
        'Total Water Usage: ${_totalWaterUsage.toStringAsFixed(2)} liters';

    await saveResult(result);
    setState(() {
      previousResults.add(result); // Update the UI immediately
    });

    _updatePoints(); // Update points based on category

    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Water Usage Feedback'),
        content: Text(
            '${_getUsageFeedback()}\n\n$result\n\nPoints Earned: $_points'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Method to update points based on water usage category
  void _updatePoints() {
    String category = _getUsageCategory();
    if (category == 'low') {
      _points += 10;
    } else if (category == 'average') {
      _points += 5;
    } else {
      _points -= 2;
    }
  }

  // Method to build input fields
  Widget _buildInputField(
      String label, Function(String) onChanged, String hint) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Method to build switch fields
  Widget _buildSwitchField(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Method to build the previous results section
  Widget _buildPreviousResults() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Previous Results',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...previousResults.map((result) => Text(result)),
          ],
        ),
      ),
    );
  }

  // Method to build the usage chart
  Widget _buildUsageChart() {
    if (_usageHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: true),
              gridData: const FlGridData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: _usageHistory
                      .asMap()
                      .entries
                      .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                      .toList(),
                  isCurved: true,
                  color: Colors.blue, // Use 'color' instead of 'colors'
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Survey'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildInputField(
                  'Household Members', (value) => _householdMembers = int.parse(value), 'Enter number'),
              _buildInputField(
                  'Shower Duration (minutes)', (value) => _showerDuration = int.parse(value), 'Enter duration'),
              _buildSwitchField(
                  'Low Flow Shower', _hasLowFlowShower, (value) => setState(() => _hasLowFlowShower = value)),
              _buildInputField(
                  'Kitchen Faucet Time (minutes)', (value) => _kitchenFaucetTime = double.parse(value), 'Enter time'),
              _buildSwitchField(
                  'Low Flow Kitchen Sink', _usesLowFlowKitchenSink, (value) => setState(() => _usesLowFlowKitchenSink = value)),
              _buildInputField(
                  'Laundry per Week', (value) => _laundryPerWeek = int.parse(value), 'Enter frequency'),
              _buildSwitchField('Has Garden', _hasGarden, (value) => setState(() => _hasGarden = value)),
              if (_hasGarden) _buildInputField(
                  'Garden Water Usage (liters)', (value) => _gardenWaterUsage = double.parse(value), 'Enter usage'),
              if (_hasGarden) _buildInputField(
                  'Watering Frequency (times per week)', (value) => _wateringFrequency = int.parse(value), 'Enter frequency'),
              ElevatedButton(
                onPressed: _submitResults,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              _buildPreviousResults(),
              const SizedBox(height: 20),
              _buildUsageChart(),
            ],
          ),
        ),
      ),
    );
  }
}
