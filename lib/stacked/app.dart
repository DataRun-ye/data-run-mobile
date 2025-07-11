import 'package:datarunmobile/data_run/d_activity/activity_page_old.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_page_new.dart';
import 'package:datarunmobile/data_run/screens/home_screen/settings/settings_page.dart';
import 'package:datarunmobile/data_run/screens/home_screen/home_screen_old.widget.dart';
import 'package:datarunmobile/data_run/screens/home_screen/settings/settings_view.dart';
import 'package:datarunmobile/data_run/screens/sync_screen/sync_screen.widget.dart';
import 'package:datarunmobile/features/sync/presentation/sync_with_server_view.dart';
import 'package:datarunmobile/data_run/screens/home_screen/home_wrapper_page.dart';
import 'package:datarunmobile/ui/info_alert/info_alert_dialog.dart';
import 'package:datarunmobile/ui/notice/notice_sheet.dart';
import 'package:datarunmobile/ui/views/login/presentation/login_view.dart';
import 'package:datarunmobile/ui/views/startup/startup_view.dart';
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
