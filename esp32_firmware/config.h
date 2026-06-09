#ifndef CONFIG_H
#define CONFIG_H

constexpr const char* WIFI_SSID = "realme 10 Pro 5G";
constexpr const char* WIFI_PASSWORD = "Ashique.";

constexpr const char* MQTT_BROKER = "broker.hivemq.com";
constexpr int MQTT_PORT = 1883;

constexpr const char* DEVICE_ID = "esp32-c3-001";

constexpr const char* TOPIC_ENVIRONMENT =
  "home/lab/device1/environment";

constexpr const char* TOPIC_STATUS =
  "home/lab/device1/status";

#endif