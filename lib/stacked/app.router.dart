// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// // **************************************************************************
// // StackedNavigatorGenerator
// // **************************************************************************
//
// // ignore_for_file: no_leading_underscores_for_library_prefixes
// import 'package:datarunmobile/data_run/screens/home_screen/drawer/settings_page.dart'
//     as _i5;
// import 'package:datarunmobile/data_run/screens/home_screen/home_screen.widget.dart'
//     as _i2;
// import 'package:datarunmobile/data_run/screens/login_screen/login_page.dart'
//     as _i3;
// import 'package:datarunmobile/modular/assignment_module/activity/activity_list_view.dart'
//     as _i6;
// import 'package:datarunmobile/ui/views/activity/activity_detail_view.dart'
//     as _i7;
// import 'package:datarunmobile/ui/views/sync_with_server/sync_with_server.view.dart'
//     as _i8;
// import 'package:flutter/material.dart' as _i9;
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart' as _i1;
// import 'package:stacked_services/stacked_services.dart' as _i10;
//
// class Routes {
//   static const homeScreen = '/home-screen';
//
//   static const loginPage = '/login-page';
//
//   // static const startupView = '/startup-view';
//
//   static const settingsPage = '/settings-page';
//
//   // static const activityListView = '/activity-list-view';
//
//   // static const activityDetailView = '/activity-detail-view';
//
//   static const syncProgressView = '/sync-progress-view';
//
//   static const all = <String>{
//     homeScreen,
//     loginPage,
//     // startupView,
//     settingsPage,
//     // activityListView,
//     // activityDetailView,
//     syncProgressView,
//   };
// }
//
// class StackedRouter extends _i1.RouterBase {
//   final _routes = <_i1.RouteDef>[
//     _i1.RouteDef(
//       Routes.homeScreen,
//       page: _i2.HomeScreen,
//     ),
//     _i1.RouteDef(
//       Routes.loginPage,
//       page: _i3.LoginPage,
//     ),
//     // _i1.RouteDef(
//     //   Routes.startupView,
//     //   page: _i4.StartupView,
//     // ),
//     _i1.RouteDef(
//       Routes.settingsPage,
//       page: _i5.SettingsPage,
//     ),
//     // _i1.RouteDef(
//     //   Routes.activityListView,
//     //   page: _i6.ActivityListView,
//     // ),
//     // _i1.RouteDef(
//     //   Routes.activityDetailView,
//     //   page: _i7.ActivityDetailView,
//     // ),
//     _i1.RouteDef(
//       Routes.syncProgressView,
//       page: _i8.SyncProgressView,
//     ),
//   ];
//
//   final _pagesMap = <Type, _i1.StackedRouteFactory>{
//     _i2.HomeScreen: (data) {
//       final args = data.getArgs<HomeScreenArguments>(
//         orElse: () => const HomeScreenArguments(),
//       );
//       return _i9.MaterialPageRoute<dynamic>(
//         builder: (context) =>
//             _i2.HomeScreen(key: args.key, refresh: args.refresh),
//         settings: data,
//       );
//     },
//     _i3.LoginPage: (data) {
//       return _i9.MaterialPageRoute<dynamic>(
//         builder: (context) => const _i3.LoginPage(),
//         settings: data,
//       );
//     },
//     // _i4.StartupView: (data) {
//     //   return _i9.MaterialPageRoute<dynamic>(
//     //     builder: (context) => const _i4.StartupView(),
//     //     settings: data,
//     //   );
//     // },
//     _i5.SettingsPage: (data) {
//       return _i9.MaterialPageRoute<dynamic>(
//         builder: (context) => _i5.SettingsPage(),
//         settings: data,
//       );
//     },
//     // _i6.ActivityListView: (data) {
//     //   return _i9.MaterialPageRoute<dynamic>(
//     //     builder: (context) => const _i6.ActivityListView(),
//     //     settings: data,
//     //   );
//     // },
//     _i7.ActivityDetailView: (data) {
//       return _i9.MaterialPageRoute<dynamic>(
//         builder: (context) => const _i7.ActivityDetailView(),
//         settings: data,
//       );
//     },
//     _i8.SyncProgressView: (data) {
//       return _i9.MaterialPageRoute<dynamic>(
//         builder: (context) => const _i8.SyncProgressView(),
//         settings: data,
//       );
//     },
//   };
//
//   @override
//   List<_i1.RouteDef> get routes => _routes;
//
//   @override
//   Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
// }
//
// class HomeScreenArguments {
//   const HomeScreenArguments({
//     this.key,
//     this.refresh = false,
//   });
//
//   final _i9.Key? key;
//
//   final bool refresh;
//
//   @override
//   String toString() {
//     return '{"key": "$key", "refresh": "$refresh"}';
//   }
//
//   @override
//   bool operator ==(covariant HomeScreenArguments other) {
//     if (identical(this, other)) return true;
//     return other.key == key && other.refresh == refresh;
//   }
//
//   @override
//   int get hashCode {
//     return key.hashCode ^ refresh.hashCode;
//   }
// }
//
// extension NavigatorStateExtension on _i10.NavigationService {
//   Future<dynamic> navigateToHomeScreen({
//     _i9.Key? key,
//     bool refresh = false,
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   }) async {
//     return navigateTo<dynamic>(Routes.homeScreen,
//         arguments: HomeScreenArguments(key: key, refresh: refresh),
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
//
//   Future<dynamic> navigateToLoginPage([
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   ]) async {
//     return navigateTo<dynamic>(Routes.loginPage,
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
//
//   // Future<dynamic> navigateToStartupView([
//   //   int? routerId,
//   //   bool preventDuplicates = true,
//   //   Map<String, String>? parameters,
//   //   Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//   //       transition,
//   // ]) async {
//   //   return navigateTo<dynamic>(Routes.startupView,
//   //       id: routerId,
//   //       preventDuplicates: preventDuplicates,
//   //       parameters: parameters,
//   //       transition: transition);
//   // }
//
//   Future<dynamic> navigateToSettingsPage([
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   ]) async {
//     return navigateTo<dynamic>(Routes.settingsPage,
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
//
//   // Future<dynamic> navigateToActivityListView([
//   //   int? routerId,
//   //   bool preventDuplicates = true,
//   //   Map<String, String>? parameters,
//   //   Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//   //       transition,
//   // ]) async {
//   //   return navigateTo<dynamic>(Routes.activityListView,
//   //       id: routerId,
//   //       preventDuplicates: preventDuplicates,
//   //       parameters: parameters,
//   //       transition: transition);
//   // }
//
//   // Future<dynamic> navigateToActivityDetailView([
//   //   int? routerId,
//   //   bool preventDuplicates = true,
//   //   Map<String, String>? parameters,
//   //   Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//   //       transition,
//   // ]) async {
//   //   return navigateTo<dynamic>(Routes.activityDetailView,
//   //       id: routerId,
//   //       preventDuplicates: preventDuplicates,
//   //       parameters: parameters,
//   //       transition: transition);
//   // }
//
//   Future<dynamic> navigateToSyncProgressView([
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   ]) async {
//     return navigateTo<dynamic>(Routes.syncProgressView,
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
//
//   Future<dynamic> replaceWithHomeScreen({
//     _i9.Key? key,
//     bool refresh = false,
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   }) async {
//     return replaceWith<dynamic>(Routes.homeScreen,
//         arguments: HomeScreenArguments(key: key, refresh: refresh),
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
//
//   Future<dynamic> replaceWithLoginPage([
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   ]) async {
//     return replaceWith<dynamic>(Routes.loginPage,
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
//
//   // Future<dynamic> replaceWithStartupView([
//   //   int? routerId,
//   //   bool preventDuplicates = true,
//   //   Map<String, String>? parameters,
//   //   Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//   //       transition,
//   // ]) async {
//   //   return replaceWith<dynamic>(Routes.startupView,
//   //       id: routerId,
//   //       preventDuplicates: preventDuplicates,
//   //       parameters: parameters,
//   //       transition: transition);
//   // }
//
//   Future<dynamic> replaceWithSettingsPage([
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   ]) async {
//     return replaceWith<dynamic>(Routes.settingsPage,
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
//
//   // Future<dynamic> replaceWithActivityListView([
//   //   int? routerId,
//   //   bool preventDuplicates = true,
//   //   Map<String, String>? parameters,
//   //   Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//   //       transition,
//   // ]) async {
//   //   return replaceWith<dynamic>(Routes.activityListView,
//   //       id: routerId,
//   //       preventDuplicates: preventDuplicates,
//   //       parameters: parameters,
//   //       transition: transition);
//   // }
//
//   // Future<dynamic> replaceWithActivityDetailView([
//   //   int? routerId,
//   //   bool preventDuplicates = true,
//   //   Map<String, String>? parameters,
//   //   Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//   //       transition,
//   // ]) async {
//   //   return replaceWith<dynamic>(Routes.activityDetailView,
//   //       id: routerId,
//   //       preventDuplicates: preventDuplicates,
//   //       parameters: parameters,
//   //       transition: transition);
//   // }
//
//   Future<dynamic> replaceWithSyncProgressView([
//     int? routerId,
//     bool preventDuplicates = true,
//     Map<String, String>? parameters,
//     Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
//         transition,
//   ]) async {
//     return replaceWith<dynamic>(Routes.syncProgressView,
//         id: routerId,
//         preventDuplicates: preventDuplicates,
//         parameters: parameters,
//         transition: transition);
//   }
// }
