#include "sensor_manager.h"
#include "wifi_manager.h"

void setup() {
  Serial.begin(115200);

  initSensor();

  initWiFi();
}

void loop() {
  handleWiFi();

  SensorData data = readSensor();

  if (data.isValid) {
    Serial.print("Temperature: ");
    Serial.println(data.temperature);

    Serial.print("Humidity: ");
    Serial.println(data.humidity);
  }

  Serial.println("----------------");

  delay(5000);
}