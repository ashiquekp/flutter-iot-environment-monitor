#include "sensor_manager.h"

#include <DHT.h>

#define DHT_PIN 2
#define DHT_TYPE DHT11

DHT dht(DHT_PIN, DHT_TYPE);

void initSensor() {
  dht.begin();
}

SensorData readSensor() {
  SensorData data;

  data.temperature = dht.readTemperature();
  data.humidity = dht.readHumidity();

  if (isnan(data.temperature) || isnan(data.humidity)) {
    data.isValid = false;
    return data;
  }

  data.isValid = true;

  return data;
}