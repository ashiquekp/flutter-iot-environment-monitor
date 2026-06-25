import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/notifications/notification_service.dart';
import '../models/alert_level.dart';
import '../models/environment_alert.dart';
import '../models/sensor_reading.dart';

class AlertNotifier extends StateNotifier<List<EnvironmentAlert>> {
  AlertNotifier() : super([]);

  double maxTemperature = 35;

  double maxHumidity = 80;

  void updateThresholds({
    required double temperature,
    required double humidity,
  }) {
    maxTemperature = temperature;

    maxHumidity = humidity;
  }

  void evaluate(SensorReading reading) {
    final alerts = <EnvironmentAlert>[];

    if (reading.temperature > maxTemperature) {
      alerts.add(
        EnvironmentAlert(
          title: 'High Temperature',
          message: 'Temperature exceeded ${maxTemperature.round()}°C',
          level: AlertLevel.warning,
          createdAt: DateTime.now(),
        ),
      );

      NotificationService.show(
        title: '⚠️ High Temperature',
        body:
            '${reading.temperature.toStringAsFixed(1)}°C exceeds threshold of ${maxTemperature.round()}°C',
      );
    }

    if (reading.humidity > maxHumidity) {
      alerts.add(
        EnvironmentAlert(
          title: 'High Humidity',
          message: 'Humidity exceeded ${maxHumidity.round()}%',
          level: AlertLevel.warning,
          createdAt: DateTime.now(),
        ),
      );

      NotificationService.show(
        title: '💧 High Humidity',
        body:
            '${reading.humidity.toStringAsFixed(1)}% exceeds threshold of ${maxHumidity.round()}%',
      );
    }

    state = alerts;
  }
}

final alertProvider =
    StateNotifierProvider<AlertNotifier, List<EnvironmentAlert>>(
      (ref) => AlertNotifier(),
    );
