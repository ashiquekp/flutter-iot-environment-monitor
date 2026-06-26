import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/sensor_reading.dart';

class CsvExportService {
  static Future<void> exportAndShare(List<SensorReading> history) async {
    final directory = await getApplicationDocumentsDirectory();

    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final file = File('${directory.path}/telemetry_$timestamp.csv');

    final buffer = StringBuffer();

    buffer.writeln('Time,Temperature,Humidity');

    for (final reading in history) {
      buffer.writeln(
        '${reading.receivedAt.toIso8601String()},'
        '${reading.temperature.toStringAsFixed(2)},'
        '${reading.humidity.toStringAsFixed(2)}',
      );
    }

    await file.writeAsString(buffer.toString());

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'EnviroMonitor Telemetry Export',
      subject: 'Telemetry CSV',
    );
  }
}
