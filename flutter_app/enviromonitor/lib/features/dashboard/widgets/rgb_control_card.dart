import 'package:flutter/material.dart';

class RgbControlCard extends StatelessWidget {
  final double red;
  final double green;
  final double blue;
  final double brightness;

  final ValueChanged<double> onRedChanged;
  final ValueChanged<double> onGreenChanged;
  final ValueChanged<double> onBlueChanged;
  final ValueChanged<double> onBrightnessChanged;

  const RgbControlCard({
    super.key,
    required this.red,
    required this.green,
    required this.blue,
    required this.brightness,
    required this.onRedChanged,
    required this.onGreenChanged,
    required this.onBlueChanged,
    required this.onBrightnessChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RGB Strip Control',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color.fromRGBO(red.round(), green.round(), blue.round(), 1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        const SizedBox(height: 16),

        Text('Red: ${red.round()}'),

        Slider(
          value: red,
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: onRedChanged,
        ),

        Text('Green: ${green.round()}'),

        Slider(
          value: green,
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: onGreenChanged,
        ),

        Text('Blue: ${blue.round()}'),

        Slider(
          value: blue,
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: onBlueChanged,
        ),

        Text('Brightness: ${brightness.round()}'),

        Slider(
          value: brightness,
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: onBrightnessChanged,
        ),
      ],
    );
  }
}
