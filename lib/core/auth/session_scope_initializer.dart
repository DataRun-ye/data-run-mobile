import 'package:d_sdk/di/init_authenticated_scope.dart';
import 'package:d_sdk/user_session/user_session.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const String authenticatedScope = 'authenticatedScope';

@Singleton()
class SessionScopeInitializer {
  SessionScopeInitializer({required SessionRepository sessionRepository})
      : _sessionRepository = sessionRepository;

  final SessionRepository _sessionRepository;

  Future<dynamic> initAuthScope() async {
    WidgetsFlutterBinding.ensureInitialized();
    return initActiveSessionScope(appLocator,
        dispose: () => _sessionRepository.clearActiveSession());
  }

  Future<bool> popAuthScope() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _sessionRepository.clearActiveSession();
    return appLocator.popScopesTill(SessionContext.activeSessionScope);
  }
}
