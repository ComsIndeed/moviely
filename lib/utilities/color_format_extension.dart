import 'package:flutter/material.dart';

extension ColorFormatExtension on Color {
  Color withHSL({double? h, double? s, double? l}) {
    Color color = this;
    if (h != null) {
      color = HSLColor.fromColor(color).withHue(h).toColor();
    }
    if (s != null) {
      color = HSLColor.fromColor(color).withSaturation(s).toColor();
    }
    if (l != null) {
      color = HSLColor.fromColor(color).withLightness(l).toColor();
    }
    return color;
  }

  HSLColor toHSL() {
    return HSLColor.fromColor(this);
  }
}
