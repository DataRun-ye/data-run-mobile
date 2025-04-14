// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:datarunmobile/data_run/screens/home_screen/drawer/settings_page.dart'
    as _i3;
import 'package:datarunmobile/data_run/screens/home_screen/home_screen.widget.dart'
    as _i1;
import 'package:datarunmobile/data_run/screens/login_screen/login_page.dart'
    as _i2;
import 'package:datarunmobile/ui/views/startup/startup_view.dart' as _i4;
import 'package:datarunmobile/ui/views/sync_with_server/sync_with_server_view.dart'
    as _i5;
import 'package:flutter/material.dart' as _i7;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i7.Key? key,
    bool refresh = false,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, refresh: refresh),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return _i1.HomeScreen(key: args.key, refresh: args.refresh);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, this.refresh = false});

  final _i7.Key? key;

  final bool refresh;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, refresh: $refresh}';
  }
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.SettingsPage]
class SettingsRoute extends _i6.PageRouteInfo<void> {
  const SettingsRoute({List<_i6.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i3.SettingsPage();
    },
  );
}

/// generated route for
/// [_i4.StartupView]
class StartupRoute extends _i6.PageRouteInfo<void> {
  const StartupRoute({List<_i6.PageRouteInfo>? children})
    : super(StartupRoute.name, initialChildren: children);

  static const String name = 'StartupRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.StartupView();
    },
  );
}

/// generated route for
/// [_i5.SyncProgressView]
class SyncProgressRoute extends _i6.PageRouteInfo<void> {
  const SyncProgressRoute({List<_i6.PageRouteInfo>? children})
    : super(SyncProgressRoute.name, initialChildren: children);

  static const String name = 'SyncProgressRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SyncProgressView();
    },
  );
}
