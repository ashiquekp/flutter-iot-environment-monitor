import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../models/sensor_reading.dart';

class RecentReadingsSection extends StatelessWidget {
  final List<SensorReading> history;

  const RecentReadingsSection({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Readings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        ...history.map(
          (reading) => Card(
            child: ListTile(
              title: Text(
                '${reading.temperature.toStringAsFixed(1)} °C',
              ),
              subtitle: Text(
                '${reading.humidity.toStringAsFixed(1)} %',
              ),
              trailing: Text(
                formatTime(reading.receivedAt),
              ),
            ),
          ),
        ),
      ],
    );
  }
}