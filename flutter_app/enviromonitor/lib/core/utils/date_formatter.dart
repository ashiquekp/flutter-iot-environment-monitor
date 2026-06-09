String formatTime(
  DateTime dateTime,
) {
  final hour =
      dateTime.hour > 12
          ? dateTime.hour - 12
          : dateTime.hour;

  final amPm =
      dateTime.hour >= 12
          ? 'PM'
          : 'AM';

  return '$hour:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')} $amPm';
}
