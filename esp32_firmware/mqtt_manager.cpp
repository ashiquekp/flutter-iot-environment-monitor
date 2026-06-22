#include "mqtt_manager.h"

#include <WiFi.h>
#include <PubSubClient.h>

#include "config.h"
#include "servo_manager.h"
#include "rgb_manager.h"

WiFiClient wifiClient;
PubSubClient mqttClient(wifiClient);

void mqttCallback(
  char* topic,
  byte* payload,
  unsigned int length
) {

  String message;

  for (
    unsigned int i = 0;
    i < length;
    i++
  ) {
    message += (char)payload[i];
  }

  Serial.println("Command Received:");
  Serial.println(message);

  if (
    message.indexOf("led_on") >= 0
  ) {

    digitalWrite(
      ALERT_LED_PIN,
      HIGH
    );

    Serial.println("LED ON");
  }

  else if (
    message.indexOf("led_off") >= 0
  ) {

    digitalWrite(
      ALERT_LED_PIN,
      LOW
    );

    Serial.println("LED OFF");
  }

  else if (
    message.indexOf("\"command\":\"servo\"") >= 0
  ) {

    int angleIndex =
      message.indexOf("\"angle\":");

    if (
      angleIndex >= 0
    ) {

      String angleString =
        message.substring(
          angleIndex + 8
        );

      angleString.replace(
        "}",
        ""
      );

      int angle =
        angleString.toInt();

      setServoAngle(
        angle
      );

      Serial.print(
        "Servo Angle: "
      );

      Serial.println(
        angle
      );
    }
  }

  else if (
    message.indexOf("\"command\":\"rgb\"") >= 0
  ) {

    int r = 255;
    int g = 255;
    int b = 255;
    int brightness = 100;

    int rIndex =
      message.indexOf("\"r\":");

    int gIndex =
      message.indexOf("\"g\":");

    int bIndex =
      message.indexOf("\"b\":");

    int brightnessIndex =
      message.indexOf("\"brightness\":");

    if (rIndex >= 0) {

      String value =
        message.substring(
          rIndex + 4
        );

      int comma =
        value.indexOf(",");

      if (comma >= 0) {
        value =
          value.substring(
            0,
            comma
          );
      }

      r = value.toInt();
    }

    if (gIndex >= 0) {

      String value =
        message.substring(
          gIndex + 4
        );

      int comma =
        value.indexOf(",");

      if (comma >= 0) {
        value =
          value.substring(
            0,
            comma
          );
      }

      g = value.toInt();
    }

    if (bIndex >= 0) {

      String value =
        message.substring(
          bIndex + 4
        );

      int comma =
        value.indexOf(",");

      if (comma >= 0) {
        value =
          value.substring(
            0,
            comma
          );
      }

      b = value.toInt();
    }

    if (
      brightnessIndex >= 0
    ) {

      String value =
        message.substring(
          brightnessIndex + 13
        );

      value.replace(
        "}",
        ""
      );

      brightness =
        value.toInt();
    }

    setRgbColor(
      r,
      g,
      b,
      brightness
    );

    Serial.print("R=");
    Serial.print(r);

    Serial.print(" G=");
    Serial.print(g);

    Serial.print(" B=");
    Serial.print(b);

    Serial.print(" Brightness=");
    Serial.println(brightness);
  }
}

void reconnectMQTT() {

  while (!mqttClient.connected()) {

    Serial.print(
      "Connecting to MQTT..."
    );

    String clientId =
      String(DEVICE_ID) +
      "-" +
      String(
        random(
          1000,
          9999
        )
      );

    String offlinePayload =
      "{"
      "\"deviceId\":\"" +
      String(DEVICE_ID) +
      "\","
      "\"status\":\"offline\""
      "}";

    if (
      mqttClient.connect(
        clientId.c_str(),
        nullptr,
        nullptr,
        TOPIC_STATUS,
        0,
        true,
        offlinePayload.c_str()
      )
    ) {

      Serial.println(
        " Connected"
      );

      mqttClient.subscribe(
        TOPIC_COMMANDS
      );

      publishDeviceStatus();

    } else {

      Serial.print(
        " Failed. State="
      );

      Serial.println(
        mqttClient.state()
      );

      delay(2000);
    }
  }
}

void initMQTT() {

  mqttClient.setServer(
    MQTT_BROKER,
    MQTT_PORT
  );

  mqttClient.setCallback(
    mqttCallback
  );
}

void handleMQTT() {

  if (
    !mqttClient.connected()
  ) {
    reconnectMQTT();
  }

  mqttClient.loop();
}

void publishDeviceStatus() {

  String payload =
    "{"
    "\"deviceId\":\"" +
    String(DEVICE_ID) +
    "\","
    "\"status\":\"online\""
    "}";

  mqttClient.publish(
    TOPIC_STATUS,
    payload.c_str()
  );
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
    String(
      temperature,
      2
    ) +
    ","
    "\"humidity\":" +
    String(
      humidity,
      2
    ) +
    "}";

  mqttClient.publish(
    TOPIC_ENVIRONMENT,
    payload.c_str()
  );
}

bool isMQTTConnected() {
  return mqttClient.connected();
}