import 'package:flutter/material.dart';

mixin KeyboardManager {
  void hideTheKeyboard(BuildContext context) {
    final FocusScopeNode currectFocus = FocusScope.of(context);
    if (!currectFocus.hasPrimaryFocus) {
      currectFocus.unfocus();
    }
  }
}
