import 'dart:async';

import 'package:flutter/material.dart';

class ThemeStream {
  Brightness _brightness;
  StreamController<Brightness> _brightnessController =
      StreamController<Brightness>();
  Stream<Brightness> get brightnessStream => _brightnessController.stream;
  StreamSink<Brightness> get _brightnessSink => _brightnessController.sink;
  Brightness get currentBrightness => _brightness;
  void setBrightness(Brightness br) {
    _brightness = br;
    _brightnessSink.add(br);
  }

  ThemeStream() {
    _brightness = Brightness.light;
  }

  void dispose() {
    _brightnessController.close();
  }
}

ThemeStream themeStream = ThemeStream();
