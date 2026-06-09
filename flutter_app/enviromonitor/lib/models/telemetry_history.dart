import 'sensor_reading.dart';

class TelemetryHistory {
  final List<SensorReading> readings;

  const TelemetryHistory({
    required this.readings,
  });
}