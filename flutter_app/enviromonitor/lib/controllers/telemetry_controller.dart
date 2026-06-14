import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/alert_provider.dart';
import '../providers/device_status_provider.dart';
import '../providers/history_provider.dart';
import '../providers/mqtt_provider.dart';

final telemetryControllerProvider = Provider<void>((ref) {
  final mqttAsync = ref.watch(mqttServiceProvider);

  mqttAsync.whenData((mqttService) {
    final telemetrySub = mqttService.telemetryStream.listen((reading) {
      ref.read(historyProvider.notifier).addReading(reading);

      ref.read(alertProvider.notifier).evaluate(reading);
    });

    final statusSub = mqttService.statusStream.listen((status) {
      if (status.status == 'online') {
        ref.read(deviceStatusProvider.notifier).setOnline();
      } else {
        ref.read(deviceStatusProvider.notifier).setOffline();
      }
    });

    ref.onDispose(() {
      telemetrySub.cancel();
      statusSub.cancel();
    });
  });
});
