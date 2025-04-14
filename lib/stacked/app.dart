import 'package:datarunmobile/data_run/screens/home_screen/drawer/settings_page.dart';
import 'package:datarunmobile/data_run/screens/home_screen/home_screen.widget.dart';
import 'package:datarunmobile/data_run/screens/login_screen/login_page.dart';
import 'package:datarunmobile/modular/activity_module/activity/activity_list_view.dart';
import 'package:datarunmobile/ui/info_alert/info_alert_dialog.dart';
import 'package:datarunmobile/ui/notice/notice_sheet.dart';
import 'package:datarunmobile/ui/views/activity/activity_detail_view.dart';
import 'package:datarunmobile/ui/views/startup/startup_view.dart';
import 'package:datarunmobile/ui/views/sync_with_server/sync_with_server_view.dart';
import 'package:stacked/stacked_annotations.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeScreen),
    // MaterialRoute(page: SyncScreen),
    MaterialRoute(page: LoginPage),
    // MaterialRoute(page: StartupView),
    MaterialRoute(page: SettingsPage),
    // MaterialRoute(page: ActivityListView),
    // MaterialRoute(page: ActivityDetailView),
    MaterialRoute(page: SyncProgressView),
    // MaterialRoute(page: AssignmentDetailView),
// @stacked-route
  ],
  dependencies: [
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
