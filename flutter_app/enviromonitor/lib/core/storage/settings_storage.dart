import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static const temperatureKey = 'temperature_threshold';

  static const humidityKey = 'humidity_threshold';

  static Future<void> saveTemperatureThreshold(double value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(temperatureKey, value);
  }

  static Future<void> saveHumidityThreshold(double value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(humidityKey, value);
  }

  static Future<double> getTemperatureThreshold() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(temperatureKey) ?? 35;
  }

  static Future<double> getHumidityThreshold() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(humidityKey) ?? 80;
  }
}
