class SensorReading {
  final String deviceId;
  final double temperature;
  final double humidity;
  final DateTime receivedAt;

  const SensorReading({
    required this.deviceId,
    required this.temperature,
    required this.humidity,
    required this.receivedAt,
  });

  factory SensorReading.fromJson(
    Map<String, dynamic> json,
  ) {
    return SensorReading(
      deviceId: json['deviceId'] as String,
      temperature:
          (json['temperature'] as num)
              .toDouble(),
      humidity:
          (json['humidity'] as num)
              .toDouble(),
      receivedAt: DateTime.now(),
    );
  }
}