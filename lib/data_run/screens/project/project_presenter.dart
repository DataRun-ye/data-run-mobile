import 'package:d2_remote/modules/auth/user/entities/d_user.entity.dart';
import 'package:mass_pro/commons/prefs/preference.dart';
import 'package:mass_pro/commons/prefs/preference_provider.dart';
import 'package:mass_pro/main/data/service/sync_status_controller.dart';
import 'package:mass_pro/main/data/service/work_manager/work_manager_controller.dart';
import 'package:mass_pro/main/data/service/work_manager/work_manager_controller_impl.dart';
import 'package:mass_pro/main/data/service/work_manager/worker_item.dart';
import 'package:mass_pro/main/data/service/work_manager/worker_type.dart';
import 'package:mass_pro/main/usescases/events_without_registration/event_initial/di/event_initial_module.dart';
import 'package:mass_pro/main/usescases/login/sync_is_performed_interactor.dart';
import 'package:mass_pro/main/usescases/sync/sync_screen_presenter.dart';
import 'package:mass_pro/data_run/screens/project/project_repository.dart';
import 'package:mass_pro/data_run/screens/project/project_repository_impl.dart';
import 'package:mass_pro/data_run/screens/project/project_screen_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_presenter.g.dart';

@Riverpod(keepAlive: true)
ProjectPresenter projectPresenter(
    ProjectPresenterRef ref, ProjectScreenView view) {
  return ProjectPresenter(
      view,
      ref.read(projectRepositoryProvider),
      ref.read(preferencesInstanceProvider),
      ref.read(workManagerControllerProvider),
      ref.read(syncStatusControllerInstanceProvider),
      ref.read(syncIsPerformedInteractorProvider));
}

class ProjectPresenter {
  ProjectPresenter(
      this.view,
      this.repository,
      this.preferencesProvider,
      this.workManagerController,
      this.syncStatusController,
      this.syncIsPerformedInteractor);

  final ProjectScreenView view;
  final ProjectRepository repository;
  final PreferenceProvider preferencesProvider;
  final WorkManagerController workManagerController;

  // final FilterManager filterManager;
  // final FilterRepository filterRepository;
  // final MatomoAnalyticsController matomoAnalyticsController;
  // final UserManager userManager;
  // final DeleteUserData deleteUserData;
  final SyncIsPerformedInteractor syncIsPerformedInteractor;

  final SyncStatusController syncStatusController;

  Future<void> init() async {
    preferencesProvider.removeValue(CURRENT_ORG_UNIT);
    repository.user().then((it) => view.renderUsername(it!.username!));
  }

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
    view.showProgressDeleteNotification();
    try {
      workManagerController.cancelAllWork();
      // deleteUserData.wipeCacheAndPreferences(view.obtainFileView())
      // userManager.d2?.wipeModule()?.wipeEverything()
      // userManager.d2?.userModule()?.accountManager()?.deleteCurrentAccount()
      view.cancelNotifications();

      view.goToLogin(await repository.accountsCount(), isDeletion: true);
    } catch (exception) {
      print('Timber.e($exception)');
    }
  }

  void onSyncAllClick() {
    view.showGranularSync();
  }

  void blockSession() {
    workManagerController.cancelAllWork();
    view.back();
  }

  void showFilter() {
    view.showHideFilter();
  }

  void onMenuClick() {
    view.openDrawer(/* 'Gravity.START' */ 0);
  }

  String _username(DUser user) {
    return '${user.firstName} ${user.surname ?? ''}';
  }

  Future<bool> hasProgramWithAssignment() {
    return repository.hasProgramWithAssignment();
  }

  void onNavigateBackToHome() {
    view.goToHome();
    // initFilters();
  }

  void onClickSyncManager() {
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

  // LiveData<SyncStatusData> observeDataSync() {
  //     return syncStatusController.observeDownloadProcess();
  // }

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

  void trackHomeAnalytics() {
    // matomoAnalyticsController.trackEvent(HOME, OPEN_ANALYTICS, CLICK)
  }

  void trackPinDialog() {
    // matomoAnalyticsController.trackEvent(HOME, BLOCK_SESSION_PIN, CLICK)
  }

  void trackQRScanner() {
    // matomoAnalyticsController.trackEvent(HOME, QR_SCANNER, CLICK)
  }

  void trackJiraReport() {
    // matomoAnalyticsController.trackEvent(HOME, JIRA_REPORT, CLICK)
  }
}