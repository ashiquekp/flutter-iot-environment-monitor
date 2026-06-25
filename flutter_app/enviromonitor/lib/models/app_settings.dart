class AppSettings {
  final double temperatureThreshold;

  final double humidityThreshold;

  const AppSettings({
    required this.temperatureThreshold,
    required this.humidityThreshold,
  });

  AppSettings copyWith({
    double? temperatureThreshold,
    double? humidityThreshold,
  }) {
    return AppSettings(
      temperatureThreshold:
          temperatureThreshold ??
          this.temperatureThreshold,
      humidityThreshold:
          humidityThreshold ??
          this.humidityThreshold,
    );
  }
}