import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Marks every screen with a "practice" ribbon while a practice session is
/// active, so nobody mistakes practice for real work, or real work for
/// practice.
class PracticeRibbon extends StatelessWidget {
  const PracticeRibbon({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
