import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/device_status.dart';

class DeviceStatusNotifier extends StateNotifier<DeviceStatus> {
  DeviceStatusNotifier() : super(DeviceStatus.unknown);

  void setOnline() {
    state = DeviceStatus.online;
  }

  void setOffline() {
    state = DeviceStatus.offline;
  }

  void setUnknown() {
    state = DeviceStatus.unknown;
  }
}

final deviceStatusProvider =
    StateNotifierProvider<DeviceStatusNotifier, DeviceStatus>(
      (ref) => DeviceStatusNotifier(),
    );
