import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Marks every screen with a "practice" ribbon while a practice session is
/// active, so nobody mistakes practice for real work, or real work for
/// practice. When the app returns to the foreground, it also ends a practice
/// session whose day is over ([AuthManager.endPracticeIfDayIsOver]).
class PracticeRibbon extends StatefulWidget {
  const PracticeRibbon({super.key, required this.child});

  final Widget child;

  @override
  State<PracticeRibbon> createState() => _PracticeRibbonState();
}

class _PracticeRibbonState extends State<PracticeRibbon> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: _endPracticeIfDayIsOver);
  }

  void _endPracticeIfDayIsOver() {
    if (!appLocator.isRegistered<AuthManager>()) return;
    unawaited(appLocator<AuthManager>()
        .endPracticeIfDayIsOver()
        .catchError((Object error, StackTrace stackTrace) {
      logError(
        'Failed to end a practice session whose day is over',
        source: error,
        stackTrace: stackTrace,
      );
    }));
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.child;
    if (!appLocator.isRegistered<AuthManager>()) return child;
    final authManager = appLocator<AuthManager>();
    return ListenableBuilder(
      listenable: authManager,
      builder: (context, _) {
        if (authManager.activeUserSession?.practice != true) return child;
        return Banner(
          message: S.of(context).practiceRibbon,
          location: BannerLocation.topEnd,
          color: Colors.deepOrange,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          child: child,
        );
      },
    );
  }
}
