#include "sensor_manager.h"
#include "wifi_manager.h"
#include "mqtt_manager.h"
#include "servo_manager.h"
#include "rgb_manager.h"
#include "config.h"

unsigned long lastPublishTime = 0;

void setup() {

  Serial.begin(115200);

  pinMode(
    ALERT_LED_PIN,
    OUTPUT
  );

  digitalWrite(
    ALERT_LED_PIN,
    LOW
  );

  initServo();

  initRgb();

  setRgbColor(
    255,
    0,
    0,
    50
  );

  initSensor();

  initWiFi();

  initMQTT();

  Serial.println(
    "System Ready"
  );
}

void loop() {

  handleWiFi();

  handleMQTT();

  unsigned long currentTime =
    millis();

  if (
    currentTime -
      lastPublishTime >=
    5000
  ) {

    lastPublishTime =
      currentTime;

    SensorData data =
      readSensor();

    if (
      data.isValid
    ) {

      publishSensorData(
        data.temperature,
        data.humidity
      );

      publishDeviceStatus();
    }

    Serial.println(
      "---------------------"
    );
  }
}