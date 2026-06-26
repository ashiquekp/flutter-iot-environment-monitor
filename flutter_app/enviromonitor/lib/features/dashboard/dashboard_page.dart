import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/telemetry_controller.dart';
import '../../../core/services/csv_export_service.dart';
import '../../../providers/alert_provider.dart';
import '../../../providers/device_status_provider.dart';
import '../../../providers/history_provider.dart';
import '../../../providers/mqtt_provider.dart';
import '../../core/services/statistics_service.dart';
import '../settings/settings_page.dart';
import 'widgets/alert_section.dart';
import 'widgets/charts_section.dart';
import 'widgets/device_status_section.dart';
import 'widgets/led_control_card.dart';
import 'widgets/recent_readings_section.dart';
import 'widgets/rgb_control_card.dart';
import 'widgets/servo_control_card.dart';
import 'widgets/smart_scenes_card.dart';
import 'widgets/statistics_section.dart';

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
            icon: const Icon(Icons.download),
            tooltip: 'Export CSV',
            onPressed: () async {
              if (history.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No telemetry data available.')),
                );
                return;
              }

              await CsvExportService.exportAndShare(history);

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('CSV exported successfully.')),
              );
            },
          ),
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

              final averageTemperature = StatisticsService.averageTemperature(
                history,
              );

              final averageHumidity = StatisticsService.averageHumidity(
                history,
              );

              final maxTemperature = StatisticsService.maxTemperature(history);

              final minTemperature = StatisticsService.minTemperature(history);

              final maxHumidity = StatisticsService.maxHumidity(history);

              final minHumidity = StatisticsService.minHumidity(history);

              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    AlertSection(alerts: alerts),

                    DeviceStatusSection(
                      deviceId: latest.deviceId,
                      deviceStatus: deviceStatus,
                      temperature: latest.temperature,
                      humidity: latest.humidity,
                      receivedAt: latest.receivedAt,
                    ),

                    const SizedBox(height: 24),

                    LedControlCard(
                      onTurnOn: mqttService.turnLedOn,
                      onTurnOff: mqttService.turnLedOff,
                    ),

                    const SizedBox(height: 24),

                    ServoControlCard(
                      angle: servoAngle,
                      onChanged: (value) {
                        setState(() {
                          servoAngle = value;
                        });

                        mqttService.setServoAngle(value.round());
                      },
                    ),

                    const SizedBox(height: 24),

                    RgbControlCard(
                      red: red,
                      green: green,
                      blue: blue,
                      brightness: brightness,

                      onRedChanged: (value) {
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

                      onGreenChanged: (value) {
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

                      onBlueChanged: (value) {
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

                      onBrightnessChanged: (value) {
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

                    SmartScenesCard(
                      onDay: () => mqttService.activateScene('day'),
                      onNight: () => mqttService.activateScene('night'),
                      onMovie: () => mqttService.activateScene('movie'),
                      onAlert: () => mqttService.activateScene('alert'),
                    ),

                    const SizedBox(height: 24),

                    StatisticsSection(
                      averageTemperature: averageTemperature,
                      averageHumidity: averageHumidity,
                      maxTemperature: maxTemperature,
                      minTemperature: minTemperature,
                      maxHumidity: maxHumidity,
                      minHumidity: minHumidity,
                    ),

                    const SizedBox(height: 24),

                    ChartsSection(history: history),

                    const SizedBox(height: 24),

                    RecentReadingsSection(history: history),
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
