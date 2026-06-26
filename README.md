# Flutter IoT Environment Monitor

# EnviroMonitor

A Flutter + ESP32 IoT monitoring platform built using MQTT and Riverpod.

The system collects environmental data from an ESP32-C3 connected to a DHT11 sensor and streams telemetry to a Flutter dashboard through MQTT.

### Technologies

Firmware:
- ESP32-C3
- Arduino IDE
- DHT11
- MQTT
- WiFi

Mobile:
- Flutter
- Riverpod
- MQTT Client

Communication:
- MQTT
- JSON

Architecture:
- Modular Firmware Design
- Service-Based Flutter Architecture
- Real-Time Telemetry Pipeline

## Hardware

- Seeed Studio XIAO ESP32C3
- DHT11 Sensor

## Planned Features

- Temperature Monitoring
- Humidity Monitoring
- MQTT Communication
- Flutter Dashboard
- Device Status Tracking

## Project Status

Day 1:
- ESP32-C3 setup completed
- Serial communication verified

Day 2:
- DHT11 integration
- Sensor abstraction layer
- Data validation
- Serial monitoring

Day 3:
- WiFi Manager module
- WiFi connectivity
- Automatic reconnection
- Configuration management

Day 4:
- MQTT Broker Integration
- MQTT Reconnection Handling
- JSON Payload Publishing
- Modular MQTT Manager
- Professional Topic Structure
- Non-blocking Scheduling using millis()

Day 5:
- MQTT Client Integration
- Riverpod State Management
- Real-Time Telemetry Updates
- JSON Payload Parsing
- Sensor Data Modeling
- Device Monitoring Dashboard

Day 6:
- Reusable dashboard widgets
- Last Updated tracking
- Date formatting utilities
- Dashboard UI refactoring
- Connection state modeling

Day 7:
- Telemetry History Buffer
- Historical Reading Storage
- Riverpod StateNotifier
- Recent Reading List
- Trend Visualization Foundation

Day 8:
- Temperature Trend Chart
- Humidity Trend Chart
- Historical Telemetry Visualization
- Time-Series Data Processing
- Reusable Chart Widgets

Day 9:
- Alert Engine
- Temperature Threshold Monitoring
- Humidity Threshold Monitoring
- Warning Generation
- Alert Dashboard Integration

Day 10:
- Device Online Detection
- Device Offline Detection
- Last Telemetry Tracking
- Device Health Monitoring

Day 11:
- Dedicated Device Status Topic
- Status Message Parsing
- Telemetry Controller
- Separation of Business Logic from UI
- Improved MQTT Architecture

Day 12:
- Centralized Telemetry Controller
- Listener Lifecycle Management
- Dashboard Simplification
- Provider Driven UI

Day 13:
- MQTT Command Topic
- Device Control from Flutter
- Bidirectional MQTT Communication
- Remote LED Control

Day 14:
- SG90 Servo Integration
- MQTT Servo Commands
- Flutter Slider Control
- Real-Time Angle Updates

Day 15:
- WS2812B RGB strip integration
- FastLED library integration
- MQTT RGB command handling
- Flutter RGB control panel
- RGB color preview widget
- Brightness control

Day 16:

The Flutter app can trigger predefined IoT scenes through MQTT where available scenes are:
- ☀️ Day Mode
  - Servo → 0°
  - RGB Strip → White
  - Alert LED → OFF

- 🌙 Night Mode
  - Servo → 180°
  - RGB Strip → Orange
  - Low Brightness

- 🎬 Movie Mode
  - Servo → 90°
  - RGB Strip → Purple
  - Low Brightness

- 🚨 Alert Mode
  - RGB Strip → Red
  - Maximum Brightness
  - Alert LED → ON

Day 17:

The application sends local notifications when:

- Temperature exceeds threshold
- Humidity exceeds threshold
- ESP32 device goes offline

Day 18:
- Local push notifications using flutter_local_notifications
- Runtime notification permission request (Android 13+)
- User configurable temperature threshold
- User configurable humidity threshold
- Settings screen for alert configuration
- Persistent alert threshold management using Riverpod
- Automatic high temperature alerts
- Automatic high humidity alerts

Day 19:
- Added Smart Scene controls (Day, Night, Movie, Alert)
- Implemented telemetry CSV export
- Added native Android share support for exported telemetry

Day 20:
- Added CSV export for telemetry history.
- Implemented reusable StatisticsService.
- Added Statistics dashboard (average, min, max values).
- Improved project structure by separating business logic from UI.

Day 21:
- Refactored DashboardPage into reusable widgets.
- Extracted Device Status and Alerts section.
- Extracted LED and Servo control widgets.
- Extracted RGB Strip and Smart Scene widgets.
- Extracted Statistics, Charts, and History widgets.
- Improved maintainability and code readability.

## Architecture

```text
DHT11 Sensor
     │
     ▼
ESP32-C3
     │
     │ MQTT
     ▼
HiveMQ Broker
     │
     ▼
Flutter Application
```

### Firmware Modules

```text
esp32_firmware/

├── esp32_firmware.ino
├── config.h
├── sensor_manager.h
├── sensor_manager.cpp
├── wifi_manager.h
├── wifi_manager.cpp
├── mqtt_manager.h
└── mqtt_manager.cpp
```

### Communication Flow

1. DHT11 measures temperature and humidity.
2. ESP32 reads sensor data.
3. Data is converted into JSON.
4. JSON is published to MQTT.
5. Flutter subscribes to MQTT topics.
6. Dashboard updates in real time.

## Technical Skills Demonstrated

### Embedded Systems

* ESP32-C3 Firmware Development
* Sensor Integration
* GPIO Communication
* Modular Firmware Architecture

### Networking

* WiFi Connectivity
* MQTT Protocol
* Publish-Subscribe Architecture
* Automatic Reconnection

### Software Engineering

* Separation of Concerns
* Configuration Management
* Structured JSON Messaging
* Git-based Development Workflow


