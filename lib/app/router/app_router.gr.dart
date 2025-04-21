// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:d_sdk/user_session/session_context.dart' as _i9;
import 'package:datarunmobile/features/dialog/presentation/platform_dialog.dart'
    as _i3;
import 'package:datarunmobile/features/home/presentation/home_view.dart' as _i1;
import 'package:datarunmobile/features/login/presentation/login_view.dart'
    as _i2;
import 'package:datarunmobile/features/settings/presentation/settings_view.dart'
    as _i4;
import 'package:datarunmobile/ui/views/startup/startup_view.dart' as _i5;
import 'package:datarunmobile/ui/views/sync_with_server/sync_with_server_view.dart'
    as _i6;
import 'package:flutter/cupertino.dart' as _i10;
import 'package:flutter/material.dart' as _i8;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i8.Key? key,
    bool refresh = false,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, refresh: refresh),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
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

  final _i8.Key? key;

  final bool refresh;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, refresh: $refresh}';
  }
}

/// generated route for
/// [_i2.LoginView]
class LoginRoute extends _i7.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i8.Key? key,
    dynamic Function(bool, _i9.SessionContext?)? onResult,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, onResult: onResult),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i2.LoginView(key: args.key, onResult: args.onResult);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onResult});

  final _i8.Key? key;

  final dynamic Function(bool, _i9.SessionContext?)? onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i3.PlatformDialogView]
class PlatformDialogRoute extends _i7.PageRouteInfo<PlatformDialogRouteArgs> {
  PlatformDialogRoute({
    _i10.Key? key,
    String? title,
    String? content,
    List<_i10.Widget>? actions,
    String? cancelText,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         PlatformDialogRoute.name,
         args: PlatformDialogRouteArgs(
           key: key,
           title: title,
           content: content,
           actions: actions,
           cancelText: cancelText,
         ),
         initialChildren: children,
       );

  static const String name = 'PlatformDialogRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PlatformDialogRouteArgs>(
        orElse: () => const PlatformDialogRouteArgs(),
      );
      return _i3.PlatformDialogView(
        key: args.key,
        title: args.title,
        content: args.content,
        actions: args.actions,
        cancelText: args.cancelText,
      );
    },
  );
}

class PlatformDialogRouteArgs {
  const PlatformDialogRouteArgs({
    this.key,
    this.title,
    this.content,
    this.actions,
    this.cancelText,
  });

  final _i10.Key? key;

  final String? title;

  final String? content;

  final List<_i10.Widget>? actions;

  final String? cancelText;

  @override
  String toString() {
    return 'PlatformDialogRouteArgs{key: $key, title: $title, content: $content, actions: $actions, cancelText: $cancelText}';
  }
}

/// generated route for
/// [_i4.SettingsView]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i4.SettingsView();
    },
  );
}

/// generated route for
/// [_i5.StartupView]
class StartupRoute extends _i7.PageRouteInfo<void> {
  const StartupRoute({List<_i7.PageRouteInfo>? children})
    : super(StartupRoute.name, initialChildren: children);

  static const String name = 'StartupRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.StartupView();
    },
  );
}

/// generated route for
/// [_i6.SyncProgressView]
class SyncProgressRoute extends _i7.PageRouteInfo<SyncProgressRouteArgs> {
  SyncProgressRoute({
    _i8.Key? key,
    dynamic Function(bool)? onResult,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         SyncProgressRoute.name,
         args: SyncProgressRouteArgs(key: key, onResult: onResult),
         initialChildren: children,
       );

  static const String name = 'SyncProgressRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SyncProgressRouteArgs>(
        orElse: () => const SyncProgressRouteArgs(),
      );
      return _i6.SyncProgressView(key: args.key, onResult: args.onResult);
    },
  );
}

class SyncProgressRouteArgs {
  const SyncProgressRouteArgs({this.key, this.onResult});

  final _i8.Key? key;

  final dynamic Function(bool)? onResult;

  @override
  String toString() {
    return 'SyncProgressRouteArgs{key: $key, onResult: $onResult}';
  }
}
