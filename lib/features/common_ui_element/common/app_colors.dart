import 'package:flutter/material.dart';

const Color kcMediumGrey = Color(0xFF474A54);

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

class DColors {
  static const Color Red200 = Color(0xFFFFE3E2);
  static const Color Red600 = Color(0xFFD21B14);
  static const Color Orange600 = Color(0xFFFB8C00);
  static const Color Orange800 = Color(0xFFEF6C00);
}

class SurfaceColors {
  static const Error = DColors.Red600;
  static const Warning = DColors.Orange800;
  static const ErrorContainerHighest = DColors.Red200;
}
