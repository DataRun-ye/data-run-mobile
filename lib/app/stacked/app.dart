import 'package:datarunmobile/features/assignment/presentation/assignment_screen.dart';
import 'package:datarunmobile/features/data_instance/presentation/table_screen.dart';
import 'package:datarunmobile/features/common_ui_element/info_alert/info_alert_dialog.dart';
import 'package:datarunmobile/features/common_ui_element/notice/notice_sheet.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_flow_bootstrapper.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_submission_screen.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_screen.dart';
import 'package:datarunmobile/features/form_submission/presentation/submission_history_screen.dart';
import 'package:datarunmobile/features/home/presentation/home_wrapper_page.dart';
import 'package:datarunmobile/features/home/presentation/settings_view.dart';
import 'package:datarunmobile/features/login/presentation/login_view.dart';
import 'package:datarunmobile/features/startup/presentation/splash_view.dart';
import 'package:datarunmobile/features/sync/presentation/sync_resources_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeWrapperPage),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SplashView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: SyncResourcesView),
    MaterialRoute(page: AssignmentScreen),
    MaterialRoute(page: EditRowScreen),
    MaterialRoute(page: SubmissionHistoryScreen),
    MaterialRoute(page: FormSubmissionScreen),
    MaterialRoute(page: FormFlowBootstrapper),
    // MaterialRoute(page: DataInstanceTableScreen),
    MaterialRoute(page: TableScreen),
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
