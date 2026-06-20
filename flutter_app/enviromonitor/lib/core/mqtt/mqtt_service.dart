import 'dart:async';
import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../models/device_status_message.dart';
import '../../models/sensor_reading.dart';

class MqttService {
  static const String broker = 'broker.hivemq.com';

  static const String telemetryTopic = 'home/lab/device1/environment';

  static const String statusTopic = 'home/lab/device1/status';

  static const String commandTopic = 'home/lab/device1/commands';

  final MqttServerClient client;

  final Stream<SensorReading> telemetryStream;

  final Stream<DeviceStatusMessage> statusStream;

  MqttService._({
    required this.client,
    required this.telemetryStream,
    required this.statusStream,
  });

  static Future<MqttService> create() async {
    final client = MqttServerClient(
      broker,
      'flutter_client_${DateTime.now().millisecondsSinceEpoch}',
    );

    client.port = 1883;
    client.keepAlivePeriod = 30;
    client.logging(on: false);

    await client.connect();

    client.subscribe(telemetryTopic, MqttQos.atLeastOnce);

    client.subscribe(statusTopic, MqttQos.atLeastOnce);

    final telemetryController = StreamController<SensorReading>.broadcast();

    final statusController = StreamController<DeviceStatusMessage>.broadcast();

    client.updates?.listen((events) {
      for (final event in events) {
        final publishMessage = event.payload as MqttPublishMessage;

        final payloadString = MqttPublishPayload.bytesToStringAsString(
          publishMessage.payload.message,
        );

        final topic = event.topic;

        try {
          final jsonMap = jsonDecode(payloadString) as Map<String, dynamic>;

          if (topic == telemetryTopic) {
            telemetryController.add(SensorReading.fromJson(jsonMap));
          } else if (topic == statusTopic) {
            statusController.add(DeviceStatusMessage.fromJson(jsonMap));
          }
        } catch (e) {
          print('MQTT Parse Error: $e');
        }
      }
    });

    return MqttService._(
      client: client,
      telemetryStream: telemetryController.stream,
      statusStream: statusController.stream,
    );
  }

  void turnLedOn() {
    _publishCommand('led_on');
  }

  void turnLedOff() {
    _publishCommand('led_off');
  }

  void _publishCommand(String command) {
    final payload = jsonEncode({'command': command});

    final builder = MqttClientPayloadBuilder();

    builder.addString(payload);

    client.publishMessage(commandTopic, MqttQos.atLeastOnce, builder.payload!);
  }

  Future<void> disconnect() async {
    client.disconnect();
  }
}
