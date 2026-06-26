import '../../models/sensor_reading.dart';

class StatisticsService {
  static double averageTemperature(List<SensorReading> history) {
    if (history.isEmpty) {
      return 0;
    }

    final total = history.fold<double>(
      0,
      (sum, reading) => sum + reading.temperature,
    );

    return total / history.length;
  }

  static double averageHumidity(List<SensorReading> history) {
    if (history.isEmpty) {
      return 0;
    }

    final total = history.fold<double>(
      0,
      (sum, reading) => sum + reading.humidity,
    );

    return total / history.length;
  }

  static double maxTemperature(List<SensorReading> history) {
    if (history.isEmpty) {
      return 0;
    }

    return history.map((e) => e.temperature).reduce((a, b) => a > b ? a : b);
  }

  static double minTemperature(List<SensorReading> history) {
    if (history.isEmpty) {
      return 0;
    }

    return history.map((e) => e.temperature).reduce((a, b) => a < b ? a : b);
  }

  static double maxHumidity(List<SensorReading> history) {
    if (history.isEmpty) {
      return 0;
    }

    return history.map((e) => e.humidity).reduce((a, b) => a > b ? a : b);
  }

  static double minHumidity(List<SensorReading> history) {
    if (history.isEmpty) {
      return 0;
    }

    return history.map((e) => e.humidity).reduce((a, b) => a < b ? a : b);
  }
}
