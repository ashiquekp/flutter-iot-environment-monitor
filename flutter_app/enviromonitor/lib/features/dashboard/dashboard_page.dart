import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/date_formatter.dart';
import '../../../providers/alert_provider.dart';
import '../../../providers/history_provider.dart';
import '../../../providers/mqtt_provider.dart';
import 'widgets/humidity_chart.dart';
import 'widgets/info_card.dart';
import 'widgets/temperature_chart.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqttAsync = ref.watch(mqttServiceProvider);

    final history = ref.watch(historyProvider);

    final alerts = ref.watch(alertProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('EnviroMonitor'), centerTitle: true),
      body: mqttAsync.when(
        data: (mqttService) {
          return StreamBuilder(
            stream: mqttService.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final reading = snapshot.data!;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(historyProvider.notifier).addReading(reading);

                  ref.read(alertProvider.notifier).evaluate(reading);
                });
              }

              if (history.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final latest = history.first;

              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Alerts Section
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
