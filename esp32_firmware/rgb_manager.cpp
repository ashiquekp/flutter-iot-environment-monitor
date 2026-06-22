#include "rgb_manager.h"

#include <FastLED.h>

#include "config.h"

CRGB leds[
  RGB_LED_COUNT
];

int currentRed = 255;
int currentGreen = 255;
int currentBlue = 255;

void initRgb() {

  FastLED.addLeds<
    WS2812B,
    RGB_PIN,
    GRB
  >(
    leds,
    RGB_LED_COUNT
  );

  FastLED.clear();

  FastLED.show();
}

void setRgbColor(
  int r,
  int g,
  int b,
  int brightness
) {

  currentRed = r;
  currentGreen = g;
  currentBlue = b;

  FastLED.setBrightness(
    brightness
  );

  for (
    int i = 0;
    i < RGB_LED_COUNT;
    i++
  ) {

    leds[i] = CRGB(
      r,
      g,
      b
    );
  }

  FastLED.show();
}

void setRgbBrightness(
  int brightness
) {

  FastLED.setBrightness(
    brightness
  );

  for (
    int i = 0;
    i < RGB_LED_COUNT;
    i++
  ) {

    leds[i] = CRGB(
      currentRed,
      currentGreen,
      currentBlue
    );
  }

  FastLED.show();
}