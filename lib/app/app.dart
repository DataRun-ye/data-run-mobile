import 'package:datarun/data_run/screens/home_screen/drawer/settings_page.dart';
import 'package:datarun/data_run/screens/home_screen/home_screen.widget.dart';
import 'package:datarun/data_run/screens/login_screen/login_page.dart';
import 'package:datarun/data_run/screens/sync_screen/sync_screen.widget.dart';
import 'package:datarun/modular/activity_module/activity/activity_list_view.dart';
import 'package:datarun/ui/info_alert/info_alert_dialog.dart';
import 'package:datarun/ui/notice/notice_sheet.dart';
import 'package:datarun/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:datarun/modular/activity_module/assignment/assignment_list_view.dart';
import 'package:datarun/modular/activity_module/activity/activity_detail/activity_detail_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: SyncScreen),
    MaterialRoute(page: LoginPage),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SettingsPage),
    MaterialRoute(page: AssignmentListView),
    MaterialRoute(page: ActivityListView),
    MaterialRoute(page: ActivityDetailView),
// @stacked-route
  ],
  dependencies: [
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
