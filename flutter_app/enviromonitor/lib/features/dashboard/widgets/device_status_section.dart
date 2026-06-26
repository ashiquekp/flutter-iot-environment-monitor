import 'package:flutter/material.dart';

import '../../../core/utils/date_formatter.dart';
import '../../../models/device_status.dart';
import '../../dashboard/widgets/info_card.dart';

class DeviceStatusSection extends StatelessWidget {
  final String deviceId;
  final DeviceStatus deviceStatus;
  final double temperature;
  final double humidity;
  final DateTime receivedAt;

  const DeviceStatusSection({
    super.key,
    required this.deviceId,
    required this.deviceStatus,
    required this.temperature,
    required this.humidity,
    required this.receivedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoCard(
          title: 'Device ID',
          value: deviceId,
        ),

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
          value: '${temperature.toStringAsFixed(1)} °C',
        ),

        InfoCard(
          title: 'Humidity',
          value: '${humidity.toStringAsFixed(1)} %',
        ),

        const InfoCard(
          title: 'MQTT Status',
          value: 'Connected',
        ),

        InfoCard(
          title: 'Last Updated',
          value: formatTime(receivedAt),
        ),
      ],
    );
  }
}