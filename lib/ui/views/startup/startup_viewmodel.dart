import 'package:d_sdk/auth/auth_manager.dart';
import 'package:datarunmobile/app/router/app_router.dart';
import 'package:datarunmobile/app/router/app_router.gr.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/session_scope_initializer.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel {
  final AuthManager _authManager = appLocator<AuthManager>();
  final SessionScopeInitializer _scopeInitializer =
      appLocator<SessionScopeInitializer>();

  Future<dynamic> runStartupLogic() async {
    try {
      if (!(await _authManager.isAuthenticated())) {
        await appLocator<AppRouter>().replace(LoginRoute());
        // _router.replace(HomeRoute());
      } else {
        await _scopeInitializer.initAuthScope();
        await appLocator<AppRouter>().replace(SyncProgressRoute());
      }
      // final needSync = await _syncScheduler.shouldSync();
      // if (needSync) {
      //   // await _navigationService.navigateToSyncProgressView();
      //   _router.replace(HomeRoute());
      //
      //   // _navigationService.replaceWithHomeScreen();
      // } else {
      //   return _router.replace(HomeRoute());
      // }
    } catch (e) {
      // _navigationService.replaceWithLoginPage();
      // debugPrintStack(stackTrace: s);
      await appLocator<AppRouter>().replace(LoginRoute());
      DExceptionReporter.instance.report(e, showToUser: true);
      rethrow;
    }
  }
}
