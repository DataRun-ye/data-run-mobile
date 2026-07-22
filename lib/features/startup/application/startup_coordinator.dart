import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupCoordinator {
  StartupCoordinator({
    required AuthManager authManager,
    required SyncScheduler syncScheduler,
    required NavigationService navigationService,
  })  : _authManager = authManager,
        _syncScheduler = syncScheduler,
        _navigationService = navigationService;

  final AuthManager _authManager;
  final SyncScheduler _syncScheduler;
  final NavigationService _navigationService;

  Future<void> run() async {
    try {
      await _authManager.initialize();
      if (!_authManager.isAuthenticated()) {
        _navigationService.replaceWithLoginView();
      } else if (await _syncScheduler.shouldSync()) {
        _navigationService.replaceWithSyncResourcesView();
      } else {
        _navigationService.replaceWithHomeWrapperPage();
      }
    } catch (error) {
      _navigationService.replaceWithLoginView();
      DExceptionReporter.instance.report(error, showToUser: true);
      rethrow;
    }
  }
}
