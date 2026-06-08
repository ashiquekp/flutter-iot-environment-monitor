#include "wifi_manager.h"

#include <WiFi.h>

#include "config.h"

void initWiFi() {
  Serial.println("Connecting to WiFi...");

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi Connected");

  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());
}

void handleWiFi() {
  if (WiFi.status() == WL_CONNECTED) {
    return;
  }

  Serial.println("WiFi Lost. Reconnecting...");

  WiFi.disconnect();

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
}

bool isWiFiConnected() {
  return WiFi.status() == WL_CONNECTED;
}