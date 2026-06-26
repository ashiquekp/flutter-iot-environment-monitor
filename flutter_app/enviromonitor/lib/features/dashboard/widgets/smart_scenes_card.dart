import 'package:flutter/material.dart';

class SmartScenesCard extends StatelessWidget {
  final VoidCallback onDay;
  final VoidCallback onNight;
  final VoidCallback onMovie;
  final VoidCallback onAlert;

  const SmartScenesCard({
    super.key,
    required this.onDay,
    required this.onNight,
    required this.onMovie,
    required this.onAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Smart Scenes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(onPressed: onDay, child: const Text('☀️ Day')),
            ElevatedButton(onPressed: onNight, child: const Text('🌙 Night')),
            ElevatedButton(onPressed: onMovie, child: const Text('🎬 Movie')),
            ElevatedButton(onPressed: onAlert, child: const Text('🚨 Alert')),
          ],
        ),
      ],
    );
  }
}
