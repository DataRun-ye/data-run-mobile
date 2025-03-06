import 'package:datarun/data_run/screens/home_screen/home_screen.widget.dart';
import 'package:datarun/data_run/screens/login_screen/login_page.dart';
import 'package:datarun/data_run/screens/sync_screen/sync_screen.widget.dart';
import 'package:datarun/ui/info_alert/info_alert_dialog.dart';
import 'package:datarun/ui/notice/notice_sheet.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: SyncScreen),
    MaterialRoute(page: LoginPage),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
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
