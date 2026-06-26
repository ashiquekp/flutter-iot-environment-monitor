class SensorReading {
  final String deviceId;

  final double temperature;

  final double humidity;

  final int wifiRssi;

  final int freeHeap;

  final int cpuFrequency;

  final int uptime;

  final DateTime receivedAt;

  const SensorReading({
    required this.deviceId,
    required this.temperature,
    required this.humidity,
    required this.wifiRssi,
    required this.freeHeap,
    required this.cpuFrequency,
    required this.uptime,
    required this.receivedAt,
  });

  factory SensorReading.fromJson(Map<String, dynamic> json) {
    return SensorReading(
      deviceId: json['deviceId'] as String,

      temperature: (json['temperature'] as num).toDouble(),

      humidity: (json['humidity'] as num).toDouble(),

      wifiRssi: (json['wifiRssi'] ?? 0) as int,

      freeHeap: (json['freeHeap'] ?? 0) as int,

      cpuFrequency: (json['cpuFrequency'] ?? 0) as int,

      uptime: (json['uptime'] ?? 0) as int,

      receivedAt: DateTime.now(),
    );
  }
}
