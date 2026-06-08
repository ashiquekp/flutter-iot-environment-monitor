#include "sensor_manager.h"
#include "wifi_manager.h"
#include "mqtt_manager.h"

unsigned long lastPublishTime = 0;

void setup() {

  Serial.begin(115200);

  initSensor();

  initWiFi();

  initMQTT();

  Serial.println("System Ready");
}

void loop() {

  handleWiFi();

  handleMQTT();

  unsigned long currentTime = millis();

  if (
    currentTime - lastPublishTime >= 5000
  ) {

    lastPublishTime = currentTime;

    SensorData data = readSensor();

    if (data.isValid) {

      Serial.print("Temperature: ");
      Serial.println(data.temperature);

      Serial.print("Humidity: ");
      Serial.println(data.humidity);

      publishSensorData(
        data.temperature,
        data.humidity
      );
    } else {

      Serial.println(
        "Invalid DHT11 reading"
      );
    }

    Serial.println(
      "---------------------"
    );
  }
}