#ifndef CONFIG_H
#define CONFIG_H

constexpr const char* WIFI_SSID = "YOUR_WIFI_NAME";
constexpr const char* WIFI_PASSWORD = "YOUR_WIFI_PASSWORD";

constexpr const char* MQTT_BROKER = "broker.hivemq.com";
constexpr int MQTT_PORT = 1883;

constexpr const char* DEVICE_ID = "esp32-c3-001";

constexpr const char* TOPIC_ENVIRONMENT =
  "home/lab/device1/environment";

constexpr const char* TOPIC_STATUS =
  "home/lab/device1/status";

constexpr const char* TOPIC_COMMANDS =
  "home/lab/device1/commands";

constexpr int ALERT_LED_PIN = D2;

constexpr int SERVO_PIN = D1;

#endif