// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/user_session/session_context.dart' as _i13;
import 'package:datarunmobile/features/activity/presentation/activity_page_old.dart'
    as _i8;
import 'package:datarunmobile/features/assignment/presentation/assignment_page_new.dart'
    as _i10;
import 'package:datarunmobile/features/home/presentation/home_screen_old.widget.dart'
    as _i2;
import 'package:datarunmobile/features/home/presentation/home_wrapper_page.dart'
    as _i3;
import 'package:datarunmobile/features/home/presentation/settings_view.dart'
    as _i7;
import 'package:datarunmobile/features/login/presentation/login_view.dart'
    as _i5;
import 'package:datarunmobile/features/startup/presentation/splash_view.dart'
    as _i6;
import 'package:datarunmobile/features/sync/presentation/sync_resources_view.dart'
    as _i9;
import 'package:datarunmobile/features/sync/presentation/sync_screen_old.widget.dart'
    as _i4;
import 'package:datarunmobile/features/sync/presentation/sync_with_server_view.dart'
    as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i14;

class Routes {
  static const homeScreen = '/home-screen';

  static const homeWrapperPage = '/home-wrapper-page';

  static const syncScreen = '/sync-screen';

  static const loginView = '/login-view';

  static const splashView = '/splash-view';

  static const settingsView = '/settings-view';

  static const activityPage = '/activity-page';

  static const syncResourcesView = '/sync-resources-view';

  static const assignmentPage = '/assignment-page';

  static const syncProgressView = '/sync-progress-view';

  static const all = <String>{
    homeScreen,
    homeWrapperPage,
    syncScreen,
    loginView,
    splashView,
    settingsView,
    activityPage,
    syncResourcesView,
    assignmentPage,
    syncProgressView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeScreen,
      page: _i2.HomeScreen,
    ),
    _i1.RouteDef(
      Routes.homeWrapperPage,
      page: _i3.HomeWrapperPage,
    ),
    _i1.RouteDef(
      Routes.syncScreen,
      page: _i4.SyncScreen,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.splashView,
      page: _i6.SplashView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i7.SettingsView,
    ),
    _i1.RouteDef(
      Routes.activityPage,
      page: _i8.ActivityPage,
    ),
    _i1.RouteDef(
      Routes.syncResourcesView,
      page: _i9.SyncResourcesView,
    ),
    _i1.RouteDef(
      Routes.assignmentPage,
      page: _i10.AssignmentPage,
    ),
    _i1.RouteDef(
      Routes.syncProgressView,
      page: _i11.SyncProgressView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeScreen: (data) {
      final args = data.getArgs<HomeScreenArguments>(
        orElse: () => const HomeScreenArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.HomeScreen(key: args.key, refresh: args.refresh),
        settings: data,
      );
    },
    _i3.HomeWrapperPage: (data) {
      final args = data.getArgs<HomeWrapperPageArguments>(
        orElse: () => const HomeWrapperPageArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.HomeWrapperPage(key: args.key, langKey: args.langKey),
        settings: data,
      );
    },
    _i4.SyncScreen: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SyncScreen(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.LoginView(key: args.key, onResult: args.onResult),
        settings: data,
      );
    },
    _i6.SplashView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.SplashView(),
        settings: data,
      );
    },
    _i7.SettingsView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.SettingsView(),
        settings: data,
      );
    },
    _i8.ActivityPage: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ActivityPage(),
        settings: data,
      );
    },
    _i9.SyncResourcesView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.SyncResourcesView(),
        settings: data,
      );
    },
    _i10.AssignmentPage: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.AssignmentPage(),
        settings: data,
      );
    },
    _i11.SyncProgressView: (data) {
      final args = data.getArgs<SyncProgressViewArguments>(
        orElse: () => const SyncProgressViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.SyncProgressView(key: args.key, onResult: args.onResult),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeScreenArguments {
  const HomeScreenArguments({
    this.key,
    this.refresh = false,
  });

  final _i12.Key? key;

  final bool refresh;

  @override
  String toString() {
    return '{"key": "$key", "refresh": "$refresh"}';
  }

  @override
  bool operator ==(covariant HomeScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.refresh == refresh;
  }

  @override
  int get hashCode {
    return key.hashCode ^ refresh.hashCode;
  }
}

class HomeWrapperPageArguments {
  const HomeWrapperPageArguments({
    this.key,
    this.langKey = 'ar',
  });

  final _i12.Key? key;

  final String langKey;

  @override
  String toString() {
    return '{"key": "$key", "langKey": "$langKey"}';
  }

  @override
  bool operator ==(covariant HomeWrapperPageArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.langKey == langKey;
  }

  @override
  int get hashCode {
    return key.hashCode ^ langKey.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({
    this.key,
    this.onResult,
  });

  final _i12.Key? key;

  final dynamic Function(
    bool,
    _i13.SessionContext?,
  )? onResult;

  @override
  String toString() {
    return '{"key": "$key", "onResult": "$onResult"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.onResult == onResult;
  }

  @override
  int get hashCode {
    return key.hashCode ^ onResult.hashCode;
  }
}

class SyncProgressViewArguments {
  const SyncProgressViewArguments({
    this.key,
    this.onResult,
  });

  final _i12.Key? key;

  final dynamic Function(bool)? onResult;

  @override
  String toString() {
    return '{"key": "$key", "onResult": "$onResult"}';
  }

  @override
  bool operator ==(covariant SyncProgressViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.onResult == onResult;
  }

  @override
  int get hashCode {
    return key.hashCode ^ onResult.hashCode;
  }
}

extension NavigatorStateExtension on _i14.NavigationService {
  Future<dynamic> navigateToHomeScreen({
    _i12.Key? key,
    bool refresh = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeScreen,
        arguments: HomeScreenArguments(key: key, refresh: refresh),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeWrapperPage({
    _i12.Key? key,
    String langKey = 'ar',
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeWrapperPage,
        arguments: HomeWrapperPageArguments(key: key, langKey: langKey),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSyncScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.syncScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i12.Key? key,
    dynamic Function(
      bool,
      _i13.SessionContext?,
    )? onResult,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key, onResult: onResult),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToActivityPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.activityPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSyncResourcesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.syncResourcesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAssignmentPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.assignmentPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSyncProgressView({
    _i12.Key? key,
    dynamic Function(bool)? onResult,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.syncProgressView,
        arguments: SyncProgressViewArguments(key: key, onResult: onResult),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeScreen({
    _i12.Key? key,
    bool refresh = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeScreen,
        arguments: HomeScreenArguments(key: key, refresh: refresh),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeWrapperPage({
    _i12.Key? key,
    String langKey = 'ar',
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeWrapperPage,
        arguments: HomeWrapperPageArguments(key: key, langKey: langKey),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSyncScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.syncScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    _i12.Key? key,
    dynamic Function(
      bool,
      _i13.SessionContext?,
    )? onResult,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key, onResult: onResult),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithActivityPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.activityPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSyncResourcesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.syncResourcesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAssignmentPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.assignmentPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSyncProgressView({
    _i12.Key? key,
    dynamic Function(bool)? onResult,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.syncProgressView,
        arguments: SyncProgressViewArguments(key: key, onResult: onResult),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
