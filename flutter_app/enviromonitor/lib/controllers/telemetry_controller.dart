import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/alert_provider.dart';
import '../providers/device_status_provider.dart';
import '../providers/history_provider.dart';
import '../providers/mqtt_provider.dart';

final telemetryControllerProvider = Provider<void>((ref) {
  ref.watch(mqttServiceProvider).whenData((mqttService) {
    mqttService.telemetryStream.listen((reading) {
      ref.read(historyProvider.notifier).addReading(reading);

      ref.read(alertProvider.notifier).evaluate(reading);
    });

    mqttService.statusStream.listen((_) {
      ref.read(deviceStatusProvider.notifier).setOnline();
    });
  });
});
