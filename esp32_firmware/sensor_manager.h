#ifndef SENSOR_MANAGER_H
#define SENSOR_MANAGER_H

struct SensorData {
  float temperature;
  float humidity;
  bool isValid;
};

void initSensor();
SensorData readSensor();

#endif