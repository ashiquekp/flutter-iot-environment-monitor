import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/date_formatter.dart';
import '../../../providers/history_provider.dart';
import '../../../providers/mqtt_provider.dart';
import 'widgets/info_card.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final mqttAsync =
        ref.watch(mqttServiceProvider);

    final history =
        ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EnviroMonitor',
        ),
        centerTitle: true,
      ),
      body: mqttAsync.when(
        data: (mqttService) {
          return StreamBuilder(
            stream: mqttService.stream,
            builder: (
              context,
              snapshot,
            ) {
              if (snapshot.hasData) {
                WidgetsBinding.instance
                    .addPostFrameCallback(
                  (_) {
                    ref
                        .read(
                          historyProvider
                              .notifier,
                        )
                        .addReading(
                          snapshot.data!,
                        );
                  },
                );
              }

              if (history.isEmpty) {
                return const Center(
                  child:
                      CircularProgressIndicator(),
                );
              }

              final latest =
                  history.first;

              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),
                  children: [
                    InfoCard(
                      title: 'Device ID',
                      value:
                          latest.deviceId,
                    ),
                    InfoCard(
                      title:
                          'Temperature',
                      value:
                          '${latest.temperature.toStringAsFixed(1)} °C',
                    ),
                    InfoCard(
                      title:
                          'Humidity',
                      value:
                          '${latest.humidity.toStringAsFixed(1)} %',
                    ),
                    const InfoCard(
                      title:
                          'MQTT Status',
                      value:
                          'Connected',
                    ),
                    InfoCard(
                      title:
                          'Last Updated',
                      value: formatTime(
                        latest.receivedAt,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Recent Readings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
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
                            formatTime(
                              reading
                                  .receivedAt,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        error:
            (error, stackTrace) =>
                Center(
          child: Text(
            error.toString(),
          ),
        ),
        loading:
            () => const Center(
          child:
              CircularProgressIndicator(),
        ),
      ),
    );
  }
}