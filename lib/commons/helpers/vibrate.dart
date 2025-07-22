import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

FutureOr<void> vibrate(BuildContext context) async {
  switch (Theme.of(context).platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      await HapticFeedback.vibrate();
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      break;
  }
}
