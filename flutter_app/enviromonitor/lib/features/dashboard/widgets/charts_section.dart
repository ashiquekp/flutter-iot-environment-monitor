import 'package:flutter/material.dart';

import '../../../../models/sensor_reading.dart';
import 'humidity_chart.dart';
import 'temperature_chart.dart';

class ChartsSection extends StatelessWidget {
  final List<SensorReading> history;

  const ChartsSection({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final chartHistory = history.reversed.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Temperature Trend',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        TemperatureChart(history: chartHistory),

        const SizedBox(height: 24),

        const Text(
          'Humidity Trend',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        HumidityChart(history: chartHistory),
      ],
    );
  }
}
