import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final AuthManager _authManager = appLocator<AuthManager>();

  final SyncScheduler _syncScheduler = appLocator<SyncScheduler>();
  final NavigationService _navigationService = appLocator<NavigationService>();

  Future<dynamic> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      await _authManager.initialize();
      if (!_authManager.isAuthenticated()) {
        _navigationService.replaceWithLoginView();
      } else {
        if (await _syncScheduler.shouldSync()) {
          _navigationService.replaceWithSyncResourcesView();
        } else {
          _navigationService.replaceWithHomeWrapperPage();
        }
      }
    } catch (e) {
      _navigationService.replaceWithLoginView();
      DExceptionReporter.instance.report(e, showToUser: true);
      rethrow;
    }
  }
}
