import 'package:datarun/commons/extensions/list_extensions.dart';
import 'package:datarun/main_constants/main_constants.dart';
import 'package:flutter/material.dart';

/// parse ThemeMode Value
ThemeMode getThemeModeValue(String? value) {
  return ThemeMode.values
          .firstOrNullWhere((enumValue) => enumValue.name == value) ??
      ThemeMode.system;
}

/// parse ThemeMode Value
ColorSeed? getColorSeedValue(String? value) {
  return ColorSeed.values
          .firstOrNullWhere((enumValue) => enumValue.label == value);
}

ColorImageProvider? getColorImageProviderValue(String? value) {
  return ColorImageProvider.values
      .firstOrNullWhere((enumValue) => enumValue.name == value);
}

ColorSelectionMethod? getColorSelectionMethodValue(String? value) {
  return ColorSelectionMethod.values
          .firstOrNullWhere((enumValue) => enumValue.name == value);
}

// ColorScheme getColorImageColorSchemeValue(String? value) {
//   return switch (value) {
//     'light' => const ColorScheme.light(),
//     'dark' => const ColorScheme.dark(),
//     _ => ColorScheme.light()
//   };
// }
