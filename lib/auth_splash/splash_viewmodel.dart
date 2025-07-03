import 'package:datarunmobile/app_routes/app_routes.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:datarunmobile/core/user_session/session_scope_initializer.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:stacked/stacked.dart';

class SplashScreenViewModel extends BaseViewModel {
  final AuthManager _authManager = appLocator<AuthManager>();
  final SessionScopeInitializer _scopeInitializer =
      appLocator<SessionScopeInitializer>();
  final AppRouter _router = appLocator<AppRouter>();
  final SyncScheduler _syncScheduler = appLocator<SyncScheduler>();

  Future<String> runStartupLogic() async {
    try {
      if (!(await _authManager.isAuthenticated())) {
        // _authManager.logout();
        return '/login';
      } else {
        await _scopeInitializer.initAuthScope();
        await _scopeInitializer.registerUserDetailInDbScope();

        if (await _syncScheduler.shouldSync()) {
          return '/sync';
          // _router.replace(SyncProgressRoute());
        } else {
          return '/home';
          // _router.replace(HomeRoute());
        }
      }
    } catch (e) {
      await _authManager.clearUserSession();
      return '/login';
      // _router.replace(LoginRoute());
      // DExceptionReporter.instance.report(e, showToUser: true);
      // rethrow;
    }
  }
}
