import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:datarunmobile/core/user_session/session_scope_initializer.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final AuthManager _authManager = appLocator<AuthManager>();
  final SessionScopeInitializer _scopeInitializer =
      appLocator<SessionScopeInitializer>();
  final SyncScheduler _syncScheduler = appLocator<SyncScheduler>();
  final NavigationService _navigationService = appLocator<NavigationService>();

  Future<dynamic> runStartupLogic() async {
    // await Future.delayed(const Duration(seconds: 3));
    try {
      await _authManager.checkAuthStatus();
      if (!_authManager.isAuthenticated()) {
        _navigationService.replaceWithLoginView();
      } else {
        // await _scopeInitializer.initAuthScope();
        // await _scopeInitializer.registerUserDetailInDbScope();

        if (await _syncScheduler.shouldSync()) {
          _navigationService.replaceWithSyncProgressView();
        } else {
          _navigationService.replaceWithHomeWrapperPage();
        }
      }
    } catch (e) {
      // await _authManager.clearUserSession();
      _navigationService.replaceWithLoginView();
      DExceptionReporter.instance.report(e, showToUser: true);
      rethrow;
    }
  }
}
