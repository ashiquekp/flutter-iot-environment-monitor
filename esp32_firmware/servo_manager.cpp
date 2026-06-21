#include "servo_manager.h"

#include <ESP32Servo.h>

#include "config.h"

Servo servo;

int currentAngle = 90;

void initServo() {

  servo.attach(
    SERVO_PIN
  );

  servo.write(
    currentAngle
  );
}

void setServoAngle(
  int angle
) {

  angle = constrain(
    angle,
    0,
    180
  );

  currentAngle = angle;

  servo.write(
    angle
  );
}

int getServoAngle() {
  return currentAngle;
}