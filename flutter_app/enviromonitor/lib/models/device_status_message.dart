class DeviceStatusMessage {
  final String deviceId;
  final String status;

  const DeviceStatusMessage({
    required this.deviceId,
    required this.status,
  });

  factory DeviceStatusMessage.fromJson(
    Map<String, dynamic> json,
  ) {
    return DeviceStatusMessage(
      deviceId: json['deviceId'],
      status: json['status'],
    );
  }
}