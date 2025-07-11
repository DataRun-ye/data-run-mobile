import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:datarunmobile/core/user_session/session_scope_initializer.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/stacked/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final AuthManager _authManager = appLocator<AuthManager>();
  final SessionScopeInitializer _scopeInitializer =
      appLocator<SessionScopeInitializer>();
  final SyncScheduler _syncScheduler = appLocator<SyncScheduler>();
  final NavigationService _navigationService = appLocator<NavigationService>();

  Future<dynamic> runStartupLogic() async {
    try {
      if (!(await _authManager.isAuthenticated())) {
        // _authManager.logout();
        _navigationService.replaceWithLoginView();
        // _router.replace(LoginRoute());
      } else {
        await _scopeInitializer.initAuthScope();
        await _scopeInitializer.registerUserDetailInDbScope();

        if (await _syncScheduler.shouldSync()) {
          _navigationService.replaceWithSyncProgressView();
          // _router.replace(SyncProgressRoute());
        } else {
          _navigationService.replaceWithHomeWrapperPage();
          // _router.replace(HomeRoute());
        }
      }
    } catch (e) {
      await _authManager.clearUserSession();
      _navigationService.replaceWithLoginView();
      // _router.replace(LoginRoute());
      DExceptionReporter.instance.report(e, showToUser: true);
      rethrow;
    }
  }
}
