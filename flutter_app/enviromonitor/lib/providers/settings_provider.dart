import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/settings_storage.dart';
import '../models/app_settings.dart';

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier()
    : super(
        const AppSettings(temperatureThreshold: 35, humidityThreshold: 80),
      ) {
    load();
  }

  Future<void> load() async {
    final temperature = await SettingsStorage.getTemperatureThreshold();

    final humidity = await SettingsStorage.getHumidityThreshold();

    state = AppSettings(
      temperatureThreshold: temperature,
      humidityThreshold: humidity,
    );
  }

  Future<void> updateTemperature(double value) async {
    await SettingsStorage.saveTemperatureThreshold(value);

    state = state.copyWith(temperatureThreshold: value);
  }

  Future<void> updateHumidity(double value) async {
    await SettingsStorage.saveHumidityThreshold(value);

    state = state.copyWith(humidityThreshold: value);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>(
  (ref) => SettingsNotifier(),
);
