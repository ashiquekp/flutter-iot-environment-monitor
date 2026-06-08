#include "sensor_manager.h"

void setup() {
  Serial.begin(115200);

  initSensor();

  Serial.println("Sensor initialized");
}

void loop() {
  SensorData data = readSensor();

  if (data.isValid) {
    Serial.print("Temperature: ");
    Serial.print(data.temperature);
    Serial.println(" °C");

    Serial.print("Humidity: ");
    Serial.print(data.humidity);
    Serial.println(" %");

    Serial.println("----------------"); 
  } else {
    Serial.println("Failed to read DHT11");
  }

  delay(2000);
}