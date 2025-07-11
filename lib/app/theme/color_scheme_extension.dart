import 'package:flutter/material.dart';

extension ColorSchemeExtension on ColorScheme {
  bool get isDark => brightness == Brightness.dark;
}
