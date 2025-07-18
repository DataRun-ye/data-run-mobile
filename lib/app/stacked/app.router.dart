// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/core/user_session/user_session.dart' as _i9;
import 'package:datarunmobile/features/assignment/presentation/assignment_screen.dart'
    as _i7;
import 'package:datarunmobile/features/home/presentation/home_wrapper_page.dart'
    as _i2;
import 'package:datarunmobile/features/home/presentation/settings_view.dart'
    as _i5;
import 'package:datarunmobile/features/login/presentation/login_view.dart'
    as _i3;
import 'package:datarunmobile/features/startup/presentation/splash_view.dart'
    as _i4;
import 'package:datarunmobile/features/sync/presentation/sync_resources_view.dart'
    as _i6;
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const homeWrapperPage = '/home-wrapper-page';

  static const loginView = '/login-view';

  static const splashView = '/splash-view';

  static const settingsView = '/settings-view';

  static const syncResourcesView = '/sync-resources-view';

  static const assignmentPage = '/assignment-page';

  static const all = <String>{
    homeWrapperPage,
    loginView,
    splashView,
    settingsView,
    syncResourcesView,
    assignmentPage,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeWrapperPage,
      page: _i2.HomeWrapperPage,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.splashView,
      page: _i4.SplashView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i5.SettingsView,
    ),
    _i1.RouteDef(
      Routes.syncResourcesView,
      page: _i6.SyncResourcesView,
    ),
    _i1.RouteDef(
      Routes.assignmentPage,
      page: _i7.AssignmentScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeWrapperPage: (data) {
      final args = data.getArgs<HomeWrapperPageArguments>(
        orElse: () => const HomeWrapperPageArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.HomeWrapperPage(key: args.key, langKey: args.langKey),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.LoginView(key: args.key, onResult: args.onResult),
        settings: data,
      );
    },
    _i4.SplashView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SplashView(),
        settings: data,
      );
    },
    _i5.SettingsView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.SettingsView(),
        settings: data,
      );
    },
    _i6.SyncResourcesView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.SyncResourcesView(),
        settings: data,
      );
    },
    _i7.AssignmentScreen: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.AssignmentScreen(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeWrapperPageArguments {
  const HomeWrapperPageArguments({
    this.key,
    this.langKey = 'ar',
  });

  final _i8.Key? key;

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

  final _i8.Key? key;

  final dynamic Function(
    bool,
    _i9.UserSession?,
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

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToHomeWrapperPage({
    _i8.Key? key,
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

  Future<dynamic> navigateToLoginView({
    _i8.Key? key,
    dynamic Function(
      bool,
      _i9.UserSession?,
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

  Future<dynamic> replaceWithHomeWrapperPage({
    _i8.Key? key,
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

  Future<dynamic> replaceWithLoginView({
    _i8.Key? key,
    dynamic Function(
      bool,
      _i9.UserSession?,
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
}
