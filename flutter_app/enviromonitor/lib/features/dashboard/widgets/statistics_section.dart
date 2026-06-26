import 'package:flutter/material.dart';

import 'statistics_card.dart';

class StatisticsSection extends StatelessWidget {
  final double averageTemperature;
  final double averageHumidity;
  final double maxTemperature;
  final double minTemperature;
  final double maxHumidity;
  final double minHumidity;

  const StatisticsSection({
    super.key,
    required this.averageTemperature,
    required this.averageHumidity,
    required this.maxTemperature,
    required this.minTemperature,
    required this.maxHumidity,
    required this.minHumidity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        StatisticsCard(
          title: 'Average Temperature',
          value: '${averageTemperature.toStringAsFixed(1)} °C',
          icon: Icons.thermostat,
        ),

        StatisticsCard(
          title: 'Average Humidity',
          value: '${averageHumidity.toStringAsFixed(1)} %',
          icon: Icons.water_drop,
        ),

        StatisticsCard(
          title: 'Highest Temperature',
          value: '${maxTemperature.toStringAsFixed(1)} °C',
          icon: Icons.arrow_upward,
        ),

        StatisticsCard(
          title: 'Lowest Temperature',
          value: '${minTemperature.toStringAsFixed(1)} °C',
          icon: Icons.arrow_downward,
        ),

        StatisticsCard(
          title: 'Highest Humidity',
          value: '${maxHumidity.toStringAsFixed(1)} %',
          icon: Icons.trending_up,
        ),

        StatisticsCard(
          title: 'Lowest Humidity',
          value: '${minHumidity.toStringAsFixed(1)} %',
          icon: Icons.trending_down,
        ),
      ],
    );
  }
}
