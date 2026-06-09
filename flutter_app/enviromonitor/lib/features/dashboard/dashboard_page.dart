import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/mqtt_provider.dart';

class DashboardPage
    extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final mqttAsync =
        ref.watch(
      mqttServiceProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EnviroMonitor',
        ),
      ),
      body: mqttAsync.when(
        data: (mqttService) {
          return StreamBuilder(
            stream: mqttService.stream,
            builder: (
              context,
              snapshot,
            ) {
              if (!snapshot.hasData) {
                return const Center(
                  child:
                      CircularProgressIndicator(),
                );
              }

              final reading =
                  snapshot.data!;

              return ListView(
                padding:
                    const EdgeInsets.all(16),
                children: [
                  Card(
                    child: ListTile(
                      title:
                          const Text(
                        'Device ID',
                      ),
                      subtitle: Text(
                        reading.deviceId,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title:
                          const Text(
                        'Temperature',
                      ),
                      subtitle: Text(
                        '${reading.temperature.toStringAsFixed(1)} °C',
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title:
                          const Text(
                        'Humidity',
                      ),
                      subtitle: Text(
                        '${reading.humidity.toStringAsFixed(1)} %',
                      ),
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      title:
                          Text(
                        'MQTT Status',
                      ),
                      subtitle:
                          Text(
                        'Connected',
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        error:
            (error, stack) =>
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