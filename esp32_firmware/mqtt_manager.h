#ifndef MQTT_MANAGER_H
#define MQTT_MANAGER_H

void initMQTT();
void handleMQTT();

void publishSensorData(
  float temperature,
  float humidity
);

bool isMQTTConnected();

#endif