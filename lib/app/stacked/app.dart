import 'package:datarunmobile/features/data_instance/presentation/table_screen.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_flow_bootstrapper.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_submission_screen.widget.dart';
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
    MaterialRoute(page: FormSubmissionScreen),
    MaterialRoute(page: FormFlowBootstrapper),
    // MaterialRoute(page: DataInstanceTableScreen),
    MaterialRoute(page: TableScreen),
    // @stacked-route
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    Singleton(classType: DialogService),
    // @stacked-service
  ],
)
class App {}
