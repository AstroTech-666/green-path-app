// ignore_for_file: depend_on_referenced_packages, unused_field

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class EnergyData {
  final DateTime date;
  final double usage;
  final String source;

  EnergyData({required this.date, required this.usage, required this.source});
}

class EnergyTrackerScreen extends StatefulWidget {
  const EnergyTrackerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EnergyTrackerScreenState createState() => _EnergyTrackerScreenState();
}

class _EnergyTrackerScreenState extends State<EnergyTrackerScreen> {
  final _energyConsumptionController = TextEditingController();
  String? _selectedSource;
  DateTime? _selectedDate;
  final List<EnergyData> _energyDataList = [];
  int _goal = 0;
  double _totalConsumption = 0.0;

  final Map<String, double> _appliancePowerRatings = {
    'Television': 0.2,
    'Air Conditioner': 1.5,
    'Microwave': 1.2,
    'Fridge': 0.3,
    'Oven': 2.1,
    'Incandescent Lamp': 0.06,
    'LED Light Bulb': 0.008,
  };

  final Map<String, String> _energySavingTips = {
    'Television':
        'Limit usage to a few hours per day and turn off when not in use.',
    'Air Conditioner':
        'Set the temperature a few degrees higher and use fans for better airflow.',
    'Microwave':
        'Use it for short cooking times and cover food to retain heat.',
    'Fridge':
        'Keep the fridge full but not overcrowded to maintain efficiency.',
    'Oven':
        'Preheat only when necessary and use a microwave or stovetop when possible.',
    'Incandescent Lamp': 'Replace with LED bulbs for lower energy consumption.',
    'LED Light Bulb':
        'Keep off when leaving a room and use natural light when possible.',
  };

  @override
  void dispose() {
    _energyConsumptionController.dispose();
    super.dispose();
  }

  void _addData(String appliance, double hours) {
    final powerInKw = _appliancePowerRatings[appliance] ?? 0;
    final energyUsage = powerInKw * hours; // Energy in kWh
    setState(() {
      if (_selectedDate != null) {
        _energyDataList.add(EnergyData(
          date: _selectedDate!,
          usage: energyUsage,
          source: appliance,
        ));
        _totalConsumption += energyUsage; // Update total consumption
      }
    });
    _energyConsumptionController.clear();
    _selectedDate = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Tracker'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Energy Consumption',
                  style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _energyConsumptionController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Hours of Usage (hours)'),
              ),
              DropdownButton<String>(
                hint: const Text('Select Appliance'),
                value: _selectedSource,
                onChanged: (value) {
                  setState(() {
                    _selectedSource = value;
                  });
                },
                items: _appliancePowerRatings.keys.map((appliance) {
                  return DropdownMenuItem<String>(
                    value: appliance,
                    child: Row(
                      children: [
                        Image.asset(getApplianceIconPath(appliance),
                            width: 24, height: 24),
                        const SizedBox(width: 8),
                        Text(appliance),
                      ],
                    ),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(_selectedDate == null
                    ? 'Select Date'
                    : DateFormat.yMMMd().format(_selectedDate!)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedSource != null &&
                      _energyConsumptionController.text.isNotEmpty) {
                    double hours;
                    try {
                      hours = double.parse(_energyConsumptionController.text);
                      if (!_appliancePowerRatings
                          .containsKey(_selectedSource!)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Selected appliance not tracked.')),
                        );
                        return;
                      }
                      _addData(_selectedSource!, hours);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please enter a valid number.')),
                      );
                    }
                  }
                },
                child: const Text('Add Energy Data'),
              ),
              const SizedBox(height: 20),
              Text('Your Energy Consumption',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: 300, // Set a fixed height for the chart
                child: _buildChart(),
              ),
              Text(
                  'Total Consumption: ${_totalConsumption.toStringAsFixed(2)} kWh',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              Text('Set Energy Goal',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: 100, // Fixed height for the goal input
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _goal = int.tryParse(value) ?? 0;
                  },
                  decoration: const InputDecoration(labelText: 'Goal (kWh)'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement goal tracking logic
                },
                child: const Text('Set Goal'),
              ),
              const SizedBox(height: 20),
              Text('Energy Savings Tips',
                  style: Theme.of(context).textTheme.titleLarge),
              SizedBox(
                height: 200, // Set a fixed height for the ListView
                child: ListView.builder(
                  itemCount: _energySavingTips.keys.length,
                  itemBuilder: (context, index) {
                    String appliance = _energySavingTips.keys.elementAt(index);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(getApplianceIconPath(appliance),
                                width: 48, height: 48),
                            const SizedBox(height: 8),
                            Text(appliance),
                            const SizedBox(height: 8),
                            Text(_energySavingTips[appliance]!,
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return BarChart(
      BarChartData(
        barGroups: _energyDataList.map((data) {
          return BarChartGroupData(
            x: data.date.millisecondsSinceEpoch,
            barRods: [
              BarChartRodData(
                toY: data.usage.toDouble(),
                color: Colors.green,
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(DateFormat.yMMMd().format(date)),
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: true),
      ),
    );
  }

  String getApplianceIconPath(String appliance) {
    switch (appliance) {
      case 'Television':
        return 'assets/icons/icon_tv.png';
      case 'Air Conditioner':
        return 'assets/icons/icon_ac.png';
      case 'Microwave':
        return 'assets/icons/icon_microwave.png';
      case 'Fridge':
        return 'assets/icons/icon_fridge.png';
      case 'Oven':
        return 'assets/icons/icon_oven.png';
      case 'Incandescent Lamp':
        return 'assets/icons/icon_lamp.png';
      case 'LED Light Bulb':
        return 'assets/icons/icon_led.png';
      default:
        return 'assets/icons/icon_default.png'; // Fallback icon
    }
  }
}
