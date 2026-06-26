import 'package:flutter/material.dart';

class LedControlCard extends StatelessWidget {
  final VoidCallback onTurnOn;
  final VoidCallback onTurnOff;

  const LedControlCard({
    super.key,
    required this.onTurnOn,
    required this.onTurnOff,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LED Control',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onTurnOn,
                child: const Text('Turn ON'),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: ElevatedButton(
                onPressed: onTurnOff,
                child: const Text('Turn OFF'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
