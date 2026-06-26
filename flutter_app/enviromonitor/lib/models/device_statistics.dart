class DeviceStatistics {
  final int packetCount;

  final double maxTemperature;

  final double minTemperature;

  final double averageTemperature;

  final double maxHumidity;

  final double minHumidity;

  final double averageHumidity;

  final DateTime? sessionStartedAt;

  const DeviceStatistics({
    required this.packetCount,
    required this.maxTemperature,
    required this.minTemperature,
    required this.averageTemperature,
    required this.maxHumidity,
    required this.minHumidity,
    required this.averageHumidity,
    required this.sessionStartedAt,
  });

  factory DeviceStatistics.empty() {
    return DeviceStatistics(
      packetCount: 0,
      maxTemperature: 0,
      minTemperature: 0,
      averageTemperature: 0,
      maxHumidity: 0,
      minHumidity: 0,
      averageHumidity: 0,
      sessionStartedAt: null,
    );
  }
}