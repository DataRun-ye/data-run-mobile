import 'package:datarunmobile/features/activity/presentation/activity_page_old.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_page_new.dart';
import 'package:datarunmobile/features/home/presentation/home_screen_old.widget.dart';
import 'package:datarunmobile/features/home/presentation/settings_view.dart';
import 'package:datarunmobile/features/login/presentation/login_view.dart';
import 'package:datarunmobile/features/startup/presentation/startup_view.dart';
import 'package:datarunmobile/features/sync/presentation/sync_screen_old.widget.dart';
import 'package:datarunmobile/features/sync/presentation/sync_with_server_view.dart';
import 'package:datarunmobile/features/home/presentation/home_wrapper_page.dart';
import 'package:datarunmobile/features/common_ui_element/info_alert/info_alert_dialog.dart';
import 'package:datarunmobile/features/common_ui_element/notice/notice_sheet.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: HomeWrapperPage),
    MaterialRoute(page: SyncScreen),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: ActivityPage),
    // MaterialRoute(page: ActivityDetailView),
    MaterialRoute(page: AssignmentPage),
    MaterialRoute(page: SyncProgressView),
    // @stacked-route
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    Singleton(classType: DialogService),
    Singleton(classType: SnackbarService),
    Singleton(classType: BottomSheetService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // StackedBottomsheet(classType: CreateSubmissionSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
