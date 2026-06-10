import 'alert_level.dart';

class EnvironmentAlert {
  final String title;
  final String message;
  final AlertLevel level;
  final DateTime createdAt;

  const EnvironmentAlert({
    required this.title,
    required this.message,
    required this.level,
    required this.createdAt,
  });
}