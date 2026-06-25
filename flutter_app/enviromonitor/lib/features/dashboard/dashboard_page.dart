import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/telemetry_controller.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../models/device_status.dart';
import '../../../providers/alert_provider.dart';
import '../../../providers/device_status_provider.dart';
import '../../../providers/history_provider.dart';
import '../../../providers/mqtt_provider.dart';
import '../settings/settings_page.dart';
import 'widgets/humidity_chart.dart';
import 'widgets/info_card.dart';
import 'widgets/temperature_chart.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  double servoAngle = 90;

  double red = 255;
  double green = 0;
  double blue = 0;
  double brightness = 100;

  @override
  Widget build(BuildContext context) {
    ref.watch(telemetryControllerProvider);

    final mqttAsync = ref.watch(mqttServiceProvider);

    final history = ref.watch(historyProvider);

    final alerts = ref.watch(alertProvider);

    final deviceStatus = ref.watch(deviceStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EnviroMonitor'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: mqttAsync.when(
        data: (mqttService) {
          return StreamBuilder(
            stream: mqttService.telemetryStream,
            builder: (context, snapshot) {
              if (history.isEmpty) {
                return const Center(child: Text('Waiting for telemetry...'));
              }

              final latest = history.first;

              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (alerts.isNotEmpty)
                      ...alerts.map(
                        (alert) => Card(
                          child: ListTile(
                            leading: const Icon(Icons.warning),
                            title: Text(alert.title),
                            subtitle: Text(alert.message),
                          ),
                        ),
                      ),

                    InfoCard(title: 'Device ID', value: latest.deviceId),

                    InfoCard(
                      title: 'Device Status',
                      value: switch (deviceStatus) {
                        DeviceStatus.online => '🟢 Online',
                        DeviceStatus.offline => '🔴 Offline',
                        DeviceStatus.unknown => '⚪ Unknown',
                      },
                    ),

                    InfoCard(
                      title: 'Temperature',
                      value: '${latest.temperature.toStringAsFixed(1)} °C',
                    ),

                    InfoCard(
                      title: 'Humidity',
                      value: '${latest.humidity.toStringAsFixed(1)} %',
                    ),

                    const InfoCard(title: 'MQTT Status', value: 'Connected'),

                    InfoCard(
                      title: 'Last Updated',
                      value: formatTime(latest.receivedAt),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'LED Control',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              mqttService.turnLedOn();
                            },
                            child: const Text('Turn ON'),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              mqttService.turnLedOff();
                            },
                            child: const Text('Turn OFF'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Servo Control',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: Text(
                        '${servoAngle.round()}°',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Slider(
                      value: servoAngle,
                      min: 0,
                      max: 180,
                      divisions: 180,
                      label: servoAngle.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          servoAngle = value;
                        });

                        mqttService.setServoAngle(value.round());
                      },
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'RGB Strip Control',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(
                          red.round(),
                          green.round(),
                          blue.round(),
                          1,
                        ),
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
                      onChanged: (value) {
                        setState(() {
                          red = value;
                        });

                        mqttService.setRgbColor(
                          r: red.round(),
                          g: green.round(),
                          b: blue.round(),
                          brightness: brightness.round(),
                        );
                      },
                    ),

                    Text('Green: ${green.round()}'),

                    Slider(
                      value: green,
                      min: 0,
                      max: 255,
                      divisions: 255,
                      onChanged: (value) {
                        setState(() {
                          green = value;
                        });

                        mqttService.setRgbColor(
                          r: red.round(),
                          g: green.round(),
                          b: blue.round(),
                          brightness: brightness.round(),
                        );
                      },
                    ),

                    Text('Blue: ${blue.round()}'),

                    Slider(
                      value: blue,
                      min: 0,
                      max: 255,
                      divisions: 255,
                      onChanged: (value) {
                        setState(() {
                          blue = value;
                        });

                        mqttService.setRgbColor(
                          r: red.round(),
                          g: green.round(),
                          b: blue.round(),
                          brightness: brightness.round(),
                        );
                      },
                    ),

                    Text('Brightness: ${brightness.round()}'),

                    Slider(
                      value: brightness,
                      min: 0,
                      max: 255,
                      divisions: 255,
                      onChanged: (value) {
                        setState(() {
                          brightness = value;
                        });

                        mqttService.setRgbColor(
                          r: red.round(),
                          g: green.round(),
                          b: blue.round(),
                          brightness: brightness.round(),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Smart Scenes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            mqttService.activateScene('day');
                          },
                          child: const Text('☀️ Day'),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            mqttService.activateScene('night');
                          },
                          child: const Text('🌙 Night'),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            mqttService.activateScene('movie');
                          },
                          child: const Text('🎬 Movie'),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            mqttService.activateScene('alert');
                          },
                          child: const Text('🚨 Alert'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Temperature Trend',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TemperatureChart(history: history.reversed.toList()),

                    const SizedBox(height: 24),

                    const Text(
                      'Humidity Trend',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    HumidityChart(history: history.reversed.toList()),

                    const SizedBox(height: 24),

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
                          trailing: Text(formatTime(reading.receivedAt)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
