import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/settings_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  late double temperatureThreshold;

  late double humidityThreshold;

  @override
  void initState() {
    super.initState();

    final settings = ref.read(settingsProvider);

    temperatureThreshold = settings.temperatureThreshold;

    humidityThreshold = settings.humidityThreshold;
  }

  @override
  Widget build(BuildContext context) {
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Temperature Alert Threshold',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Text('${temperatureThreshold.round()} °C'),

          Slider(
            value: temperatureThreshold,
            min: 20,
            max: 50,
            divisions: 30,
            onChanged: (value) {
              setState(() {
                temperatureThreshold = value;
              });
            },
          ),

          const SizedBox(height: 24),

          const Text(
            'Humidity Alert Threshold',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Text('${humidityThreshold.round()} %'),

          Slider(
            value: humidityThreshold,
            min: 30,
            max: 100,
            divisions: 70,
            onChanged: (value) {
              setState(() {
                humidityThreshold = value;
              });
            },
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: () async {
              await settingsNotifier.updateTemperature(temperatureThreshold);

              await settingsNotifier.updateHumidity(humidityThreshold);

              if (!mounted) return;

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Settings Saved')));
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
