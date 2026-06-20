#ifndef MQTT_MANAGER_H
#define MQTT_MANAGER_H

void initMQTT();

void handleMQTT();

void publishDeviceStatus();

void publishSensorData(
  float temperature,
  float humidity
);

bool isMQTTConnected();

#endif