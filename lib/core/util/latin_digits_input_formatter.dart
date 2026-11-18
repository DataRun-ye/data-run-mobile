import 'package:flutter/services.dart';

/// Converts Arabic-Indic (٠-٩) and Extended Arabic-Indic (۰-۹) digits to 0-9
/// as the user types or pastes.
///
/// Phones with an Arabic keyboard produce the former, while logins, passwords,
/// codes and numbers are stored and parsed with Latin digits. Every converted
/// digit is a single UTF-16 unit, so the cursor and selection stay valid.
class LatinDigitsInputFormatter extends TextInputFormatter {
  const LatinDigitsInputFormatter();

  static String normalize(String value) {
    StringBuffer? converted;
    for (var index = 0; index < value.length; index++) {
      final unit = value.codeUnitAt(index);
      final latin = _toLatin(unit);
      if (latin != unit && converted == null) {
        converted = StringBuffer(value.substring(0, index));
      }
      converted?.writeCharCode(latin);
    }
    return converted?.toString() ?? value;
  }

  static int _toLatin(int unit) {
    if (unit >= 0x0660 && unit <= 0x0669) return 0x30 + (unit - 0x0660);
    if (unit >= 0x06F0 && unit <= 0x06F9) return 0x30 + (unit - 0x06F0);
    return unit;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final converted = normalize(newValue.text);
    if (identical(converted, newValue.text)) return newValue;
    return newValue.copyWith(text: converted);
  }
}
