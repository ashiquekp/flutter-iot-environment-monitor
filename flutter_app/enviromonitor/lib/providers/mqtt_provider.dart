import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/mqtt/mqtt_service.dart';

final mqttServiceProvider =
    FutureProvider<MqttService>(
  (ref) async {
    return MqttService.create();
  },
);