import 'dart:async';

import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

abstract final class AppTelemetry {
  static void configure(SentryFlutterOptions options) {
    options
      ..dsn = AppEnvironment.sentryDsn
      ..navigatorKey = StackedService.navigatorKey
      ..environment = AppEnvironment.envLabel
      ..maxCacheItems = 50
      ..enableAutoSessionTracking = true
      ..attachScreenshot = false
      ..tracesSampleRate = 0.01
      ..sendDefaultPii = false
      ..reportPackages = true;

    options.feedback.isNameRequired = true;
  }

  static SentryUser userFor(UserSession session) {
    final firstName = session.firstName?.trim();

    return SentryUser(
      id: session.id,
      username: session.username,
      data: firstName == null || firstName.isEmpty
          ? null
          : {'first_name': firstName},
    );
  }

  static FutureOr<void> setUser(UserSession? session) =>
      Sentry.configureScope((scope) {
        scope.setUser(session == null ? null : userFor(session));
      });

  static Future<void> captureDevelopmentStartupCheck() async {
    if (!AppEnvironment.isDev || AppEnvironment.sentryDsn.isEmpty) return;

    await Sentry.captureMessage(
      'DataRun telemetry startup check',
      withScope: (scope) {
        scope.setTag('diagnostic', 'startup');
      },
    );
  }
}
