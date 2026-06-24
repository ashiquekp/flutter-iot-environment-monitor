import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/notifications/notification_service.dart';
import '../models/alert_level.dart';
import '../models/environment_alert.dart';
import '../models/sensor_reading.dart';

class AlertNotifier extends StateNotifier<List<EnvironmentAlert>> {
  AlertNotifier() : super([]);

  static const maxTemperature = 35.0;

  static const maxHumidity = 80.0;

  bool _temperatureAlertSent = false;

  bool _humidityAlertSent = false;

  void evaluate(SensorReading reading) {
    final alerts = <EnvironmentAlert>[];

    if (reading.temperature > maxTemperature) {
      alerts.add(
        EnvironmentAlert(
          title: 'High Temperature',
          message: 'Temperature exceeded 35°C',
          level: AlertLevel.warning,
          createdAt: DateTime.now(),
        ),
      );

      if (!_temperatureAlertSent) {
        _temperatureAlertSent = true;

        NotificationService.show(
          title: '⚠ Temperature Alert',
          body: '${reading.temperature.toStringAsFixed(1)} °C',
        );
      }
    } else {
      _temperatureAlertSent = false;
    }

    if (reading.humidity > maxHumidity) {
      alerts.add(
        EnvironmentAlert(
          title: 'High Humidity',
          message: 'Humidity exceeded 80%',
          level: AlertLevel.warning,
          createdAt: DateTime.now(),
        ),
      );

      if (!_humidityAlertSent) {
        _humidityAlertSent = true;

        NotificationService.show(
          title: '⚠ Humidity Alert',
          body: '${reading.humidity.toStringAsFixed(1)} %',
        );
      }
    } else {
      _humidityAlertSent = false;
    }

    state = alerts;
  }
}

final alertProvider =
    StateNotifierProvider<AlertNotifier, List<EnvironmentAlert>>(
      (ref) => AlertNotifier(),
    );
