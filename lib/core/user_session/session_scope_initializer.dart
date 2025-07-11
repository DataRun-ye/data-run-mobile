import 'package:d_sdk/core/exception/database_exceptions.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dbManager.dart';
import 'package:d_sdk/di/init_active_session_scope.dart';
import 'package:d_sdk/user_session/session_context.dart';
import 'package:d_sdk/user_session/session_repository.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SessionScopeInitializer {
  SessionScopeInitializer({required SessionRepository sessionRepository})
      : _sessionRepository = sessionRepository;

  final SessionRepository _sessionRepository;

  Future<dynamic> initAuthScope() async {
    WidgetsFlutterBinding.ensureInitialized();
    appLocator.enableRegisteringMultipleInstancesOfOneType();
    return initActiveSessionScope(appLocator,
        dispose: () => _sessionRepository.clearActiveSession());
  }

  /// registration of user detail should be done in db scope
  Future<User> registerUserDetailInDbScope() async {
    if (!appLocator.isRegistered<DbManager>()) {
      // registration of user detail should be done in db scope
      throw DatabaseInitException(
          message: 'can not register a user, db is not init');
    }
    final db = appLocator<DbManager>().db;
    final user = await db.select(db.users).get();
    return appLocator.registerSingleton<User>(user.first);
  }

  Future<bool> popAuthScope() async {
    WidgetsFlutterBinding.ensureInitialized();
    final activeSession =
        (await _sessionRepository.getActiveSession())?.username;
    logDebug('pop auth scope: ${activeSession}', source: this);
    final popped =
        await appLocator.popScopesTill(SessionContext.activeSessionScope);

    logDebug('auth scope ${popped ? ' Successfully removed' : 'Remove Failed'}',
        source: this);
    return popped;
  }
}
