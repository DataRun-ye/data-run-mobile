import 'package:auto_route/auto_route.dart';
import 'package:datarunmobile/app_routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page|View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: StartupRoute.page, path: '/', initial: true),
        AutoRoute(page: SyncProgressRoute.page, path: '/syncProgress'),
        AutoRoute(page: SettingsRoute.page, path: '/settings'),
        CustomRoute(
          page: PlatformDialogRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          customRouteBuilder: dialogBuilder,
          // customRouteBuilder:
          //     <T>(BuildContext context, Widget child, AutoRoutePage<T> page) {
          //   return PageRouteBuilder<T>(
          //     fullscreenDialog: page.fullscreenDialog,
          //     // this is important
          //     settings: page,
          //     pageBuilder: (_, __, ___) => child,
          //   );
          // },
        )
      ];
}

Route<T> modalSheetBuilder<T>(
    BuildContext context, Widget child, AutoRoutePage<T> page) {
  return ModalBottomSheetRoute(
    settings: page,
    builder: (context) => child,
    isScrollControlled: true,
  );
}

Route<T> dialogBuilder<T>(
    BuildContext context, Widget child, AutoRoutePage<T> page) {
  return DialogRoute(
    settings: page,
    builder: (context) => child,
    context: context,
  );
}
