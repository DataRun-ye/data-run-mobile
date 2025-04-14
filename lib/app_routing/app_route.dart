import 'package:auto_route/auto_route.dart';
import 'package:datarunmobile/app_routing/app_routing.dart';
import 'package:stacked/stacked_annotations.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page|View,Route')
@Singleton()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: StartupRoute.page, path: '/'),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          guards: [
            // AuthGuard(DSdk.authManager),
            // SyncingGuard(appLocator<SyncScheduler>())
          ],
        ),
        AutoRoute(page: LoginRoute.page, path: '/login', keepHistory: false),
        AutoRoute(
            page: SyncProgressRoute.page,
            path: '/syncProgress',
            keepHistory: false),
      ];
}
