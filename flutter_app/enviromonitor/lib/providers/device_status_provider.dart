import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/device_status.dart';

class DeviceStatusNotifier extends StateNotifier<DeviceStatus> {
  DeviceStatusNotifier() : super(DeviceStatus.offline);

  void markOnline() {
    state = DeviceStatus.online;
  }

  void markOffline() {
    state = DeviceStatus.offline;
  }
}

final deviceStatusProvider =
    StateNotifierProvider<DeviceStatusNotifier, DeviceStatus>(
      (ref) => DeviceStatusNotifier(),
    );
