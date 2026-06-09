import 'package:enviromonitor/features/dashboard/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/date_formatter.dart';
import '../../providers/mqtt_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mqttAsync = ref.watch(mqttServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('EnviroMonitor'), centerTitle: true),
      body: mqttAsync.when(
        data: (mqttService) {
          return StreamBuilder(
            stream: mqttService.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final reading = snapshot.data!;

              return RefreshIndicator(
                onRefresh: () async {},
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    InfoCard(title: 'Device ID', value: reading.deviceId),

                    InfoCard(
                      title: 'Temperature',
                      value: '${reading.temperature.toStringAsFixed(1)} °C',
                    ),

                    InfoCard(
                      title: 'Humidity',
                      value: '${reading.humidity.toStringAsFixed(1)} %',
                    ),

                    const InfoCard(title: 'MQTT Status', value: 'Connected'),

                    InfoCard(
                      title: 'Last Updated',
                      value: formatTime(reading.receivedAt),
                    ),
                  ],
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
