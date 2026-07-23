import 'dart:convert';
import 'dart:io';

import 'package:datarunmobile/core/telemetry/app_telemetry.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('configures release telemetry without sensitive screenshots', () {
    final options = SentryFlutterOptions();

    AppTelemetry.configure(options);

    expect(options.dsn, AppEnvironment.sentryDsn);
    expect(options.environment, AppEnvironment.envLabel);
    expect(options.release, isNull);
    expect(options.dist, isNull);
    expect(options.maxCacheItems, 50);
    expect(options.enableAutoSessionTracking, isTrue);
    expect(options.anrEnabled, isTrue);
    expect(options.attachScreenshot, isFalse);
    expect(options.tracesSampleRate, 0.01);
    expect(options.sendDefaultPii, isFalse);
  });

  test('projects only support identity into telemetry', () {
    final user = AppTelemetry.userFor(_userSession());

    expect(user.id, 'user-uid');
    expect(user.username, 'collector');
    expect(user.name, isNull);
    expect(user.email, isNull);
    expect(user.ipAddress, isNull);
    expect(user.data, {'first_name': 'Sensitive name'});
    expect(AppTelemetry.userFor(_userSession(firstName: '  ')).data, isNull);
  });

  test('only development and production build configs enable telemetry', () {
    final development = _config('.env/dev-config.json');
    final production = _config('.env/prod-config.json');
    final local = _config('.env/local-config.json');
    final test = _config('.env/test-config.json');

    final developmentDsn = Uri.parse(development['sentry_dsn']! as String);
    final productionDsn = Uri.parse(production['sentry_dsn']! as String);

    expect(developmentDsn, productionDsn);
    expect(developmentDsn.scheme, 'https');
    expect(developmentDsn.host, 'glitch.nmcpye.org');
    expect(developmentDsn.path, '/1');
    expect(local['sentry_dsn'], isEmpty);
    expect(test['sentry_dsn'], isEmpty);
  });
}

Map<String, Object?> _config(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, Object?>;

UserSession _userSession({String? firstName = 'Sensitive name'}) => UserSession(
      id: 'user-uid',
      username: 'collector',
      firstName: firstName,
      email: 'sensitive@example.org',
      langKey: 'ar',
      activated: true,
      authorities: [],
      activityUIDs: ['activity'],
      userTeamsUIDs: ['team'],
      managedTeamsUIDs: [],
      userGroupsUIDs: [],
      userFormsUIDs: [],
    );
