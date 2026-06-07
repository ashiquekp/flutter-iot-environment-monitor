void setup() {
  Serial.begin(115200);

  Serial.println("ESP32-C3 Booted");
}

void loop() {
  Serial.println("Running...");
  delay(1000);
}