import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../models/sensor_reading.dart';

class MqttService {
  static const broker = 'broker.hivemq.com';

  static const topic =
      'home/lab/device1/environment';

  final client = MqttServerClient(
    broker,
    'flutter_client',
  );

  final Stream<SensorReading> stream;

  MqttService._(this.stream);

  static Future<MqttService> create() async {
    final client = MqttServerClient(
      broker,
      'flutter_client_${DateTime.now().millisecondsSinceEpoch}',
    );

    client.port = 1883;

    client.keepAlivePeriod = 30;

    await client.connect();

    client.subscribe(
      topic,
      MqttQos.atLeastOnce,
    );

    final stream =
        client.updates!.map((events) {
      final payload =
          events.first.payload
              as MqttPublishMessage;

      final jsonString =
          MqttPublishPayload.bytesToStringAsString(
        payload.payload.message,
      );

      final jsonMap =
          jsonDecode(jsonString)
              as Map<String, dynamic>;

      return SensorReading.fromJson(
        jsonMap,
      );
    });

    return MqttService._(stream);
  }
}