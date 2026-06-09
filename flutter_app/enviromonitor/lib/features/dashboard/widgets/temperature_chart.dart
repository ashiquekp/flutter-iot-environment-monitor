import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/sensor_reading.dart';

class TemperatureChart
    extends StatelessWidget {
  final List<SensorReading> history;

  const TemperatureChart({
    super.key,
    required this.history,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: history
                  .asMap()
                  .entries
                  .map(
                    (entry) => FlSpot(
                      entry.key.toDouble(),
                      entry
                          .value
                          .temperature,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}