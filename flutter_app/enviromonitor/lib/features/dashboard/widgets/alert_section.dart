import 'package:flutter/material.dart';

import '../../../models/environment_alert.dart';

class AlertSection extends StatelessWidget {
  final List<EnvironmentAlert> alerts;

  const AlertSection({
    super.key,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: alerts
          .map(
            (alert) => Card(
              child: ListTile(
                leading: const Icon(Icons.warning),
                title: Text(alert.title),
                subtitle: Text(alert.message),
              ),
            ),
          )
          .toList(),
    );
  }
}