import 'package:flutter/material.dart';

class ServoControlCard extends StatelessWidget {
  final double angle;
  final ValueChanged<double> onChanged;

  const ServoControlCard({
    super.key,
    required this.angle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Servo Control',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        Center(
          child: Text(
            '${angle.round()}°',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),

        Slider(
          value: angle,
          min: 0,
          max: 180,
          divisions: 180,
          label: angle.round().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
