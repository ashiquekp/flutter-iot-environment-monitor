import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/alert_level.dart';
import '../models/environment_alert.dart';
import '../models/sensor_reading.dart';

class AlertNotifier extends StateNotifier<List<EnvironmentAlert>> {
  AlertNotifier() : super([]);

  static const maxTemperature = 35.0;
  static const maxHumidity = 80.0;

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
    }

    state = alerts;
  }
}

final alertProvider =
    StateNotifierProvider<AlertNotifier, List<EnvironmentAlert>>(
      (ref) => AlertNotifier(),
    );
