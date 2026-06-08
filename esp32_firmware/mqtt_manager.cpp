#include "mqtt_manager.h"

#include <WiFi.h>
#include <PubSubClient.h>

#include "config.h"

WiFiClient wifiClient;
PubSubClient mqttClient(wifiClient);

void reconnectMQTT() {
  while (!mqttClient.connected()) {

    Serial.print("Connecting to MQTT...");

    String clientId =
      String(DEVICE_ID) +
      "-" +
      String(random(1000, 9999));

    if (mqttClient.connect(clientId.c_str())) {

      Serial.println(" Connected");

    } else {

      Serial.print(" Failed. State=");
      Serial.println(mqttClient.state());

      delay(2000);
    }
  }
}

void initMQTT() {
  mqttClient.setServer(
    MQTT_BROKER,
    MQTT_PORT
  );
}

void handleMQTT() {

  if (!mqttClient.connected()) {
    reconnectMQTT();
  }

  mqttClient.loop();
}

void publishSensorData(
  float temperature,
  float humidity
) {

  String payload =
    "{"
    "\"deviceId\":\"" +
    String(DEVICE_ID) +
    "\","
    "\"temperature\":" +
    String(temperature, 2) +
    ","
    "\"humidity\":" +
    String(humidity, 2) +
    "}";

  mqttClient.publish(
    TOPIC_ENVIRONMENT,
    payload.c_str()
  );

  Serial.println("MQTT Published:");
  Serial.println(payload);
}

bool isMQTTConnected() {
  return mqttClient.connected();
}