// ignore_for_file: strict_raw_type

import 'package:flutter/foundation.dart';
import 'package:mass_pro/commons/prefs/preference.dart';
import 'package:mass_pro/commons/prefs/preference_provider.dart';
import 'package:mass_pro/data_run/screens/dashboard/dashboard_repository.dart';
import 'package:mass_pro/data_run/screens/dashboard/dashboard_repository_impl.dart';
import 'package:mass_pro/data_run/screens/dashboard/dashboard_screen_view.dart';
import 'package:mass_pro/main/data/service/sync_status_controller.dart';
import 'package:mass_pro/main/data/service/work_manager/work_manager_controller.dart';
import 'package:mass_pro/main/data/service/work_manager/work_manager_controller_impl.dart';
import 'package:mass_pro/main/data/service/work_manager/worker_item.dart';
import 'package:mass_pro/main/data/service/work_manager/worker_type.dart';
import 'package:mass_pro/main/usescases/login/sync_is_performed_interactor.dart';
import 'package:mass_pro/main/usescases/sync/sync_screen_presenter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_presenter.g.dart';

@Riverpod(keepAlive: true)
DashboardPresenter dashboardPresenter(
    DashboardPresenterRef ref, DashboardScreenView view) {
  return DashboardPresenter(
      view,
      ref.read(dashboardRepositoryProvider),
      ref.read(preferencesInstanceProvider),
      ref.read(workManagerControllerProvider),
      ref.read(syncStatusControllerInstanceProvider),
      ref.read(syncIsPerformedInteractorProvider));
}

class DashboardPresenter {
  DashboardPresenter(
      this.view,
      this.repository,
      this.preferencesProvider,
      this.workManagerController,
      this.syncStatusController,
      this.syncIsPerformedInteractor);

  final DashboardScreenView view;
  final DashboardRepository repository;
  final PreferenceProvider preferencesProvider;
  final WorkManagerController workManagerController;

  // final FilterManager filterManager;
  // final FilterRepository filterRepository;
  // final MatomoAnalyticsController matomoAnalyticsController;
  // final UserManager userManager;
  // final DeleteUserData deleteUserData;
  final SyncIsPerformedInteractor syncIsPerformedInteractor;

  final SyncStatusController syncStatusController;

  Future<String> getUserUid() async {
    try {
      return (await repository.user())!.uid!;
    } catch (e) {
      return '';
    }
  }

  Future<bool> logOut() {
    return Future.wait([
      workManagerController.cancelAllWork(),
      // FilterManager.getInstance().clearAllFilters(),
      preferencesProvider.setValue(SESSION_LOCKED, false),
      preferencesProvider.setValue(PIN, null)
    ])
        .then((value) => repository.logOut())
        .then((value) async =>
            view.goToLogin(await repository.accountsCount(), isDeletion: false))
        .then((_) => true);
  }

  Future onDeleteAccount() async {
    // view.showProgressDeleteNotification();
    try {
      workManagerController.cancelAllWork();
      // deleteUserData.wipeCacheAndPreferences(view.obtainFileView())
      // userManager.d2?.wipeModule()?.wipeEverything()
      // userManager.d2?.userModule()?.accountManager()?.deleteCurrentAccount()
      // view.cancelNotifications();

      view.goToLogin(await repository.accountsCount(), isDeletion: true);
    } catch (exception) {
      debugPrint('Timber.e($exception)');
    }
  }

  Future<void> onSyncAllClick() async {
    view.showGranularSync();
  }

  void blockSession() {
    workManagerController.cancelAllWork();
    view.back();
  }

  void showFilter() {
    // view.showHideFilter();
  }

  void onMenuClick() {
    view.openDrawer(/* 'Gravity.START' */ 0);
  }

  // String _username(DUser user) {
  //   return '${user.firstName} ${user.surname ?? ''}';
  // }

  Future<void> onClickSyncManager() async {
    await preferencesProvider.setValue(WAS_INITIAL_SYNC_DONE, false);
    // matomoAnalyticsController.trackEvent(HOME, SETTINGS, CLICK)
  }

  void setOpeningFilterToNone() {
    // filterRepository.collapseAllFilters();
  }

  Future<void> launchInitialDataSync() async {
    await workManagerController.syncDataForWorker(DATA_NOW, INITIAL_SYNC);
    //           required String workerName,
    // required WorkerType workerType,
    // double? delayInSeconds,
    // Map<String, dynamic>? data,
    // Duration initialDelay = Duration.zero,
    final workerItem = WorkerItem(
      workerName: RESERVED,
      workerType: WorkerType.RESERVED,
    );
    await workManagerController.cancelAllWorkByTag(workerItem.workerName);
    await workManagerController.syncDataForWorkerItem(workerItem);
  }

  Future<bool> wasSyncAlreadyDone() async {
    if (view.hasToNotSync()) {
      return true;
    }
    return syncIsPerformedInteractor();
  }

  Future<bool> onDataSuccess() async {
    return preferencesProvider.setValue(WAS_INITIAL_SYNC_DONE, true);
    // userManager.d2.dataStoreModule().localDataStore().value(WAS_INITIAL_SYNC_DONE)
    //     .blockingSet(TRUE)
  }
}
