// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:datarunmobile/core/user_session/user_session.dart' as _i11;
import 'package:datarunmobile/features/data_instance/presentation/table_screen.dart'
    as _i9;
import 'package:datarunmobile/features/form_submission/presentation/form_flow_bootstrapper.dart'
    as _i8;
import 'package:datarunmobile/features/form_submission/presentation/form_submission_screen.widget.dart'
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
import 'package:flutter/material.dart' as _i10;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i12;

class Routes {
  static const homeWrapperPage = '/home-wrapper-page';

  static const loginView = '/login-view';

  static const splashView = '/splash-view';

  static const settingsView = '/settings-view';

  static const syncResourcesView = '/sync-resources-view';

  static const formSubmissionScreen = '/form-submission-screen';

  static const formFlowBootstrapper = '/form-flow-bootstrapper';

  static const tableScreen = '/table-screen';

  static const all = <String>{
    homeWrapperPage,
    loginView,
    splashView,
    settingsView,
    syncResourcesView,
    formSubmissionScreen,
    formFlowBootstrapper,
    tableScreen,
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
      Routes.formSubmissionScreen,
      page: _i7.FormSubmissionScreen,
    ),
    _i1.RouteDef(
      Routes.formFlowBootstrapper,
      page: _i8.FormFlowBootstrapper,
    ),
    _i1.RouteDef(
      Routes.tableScreen,
      page: _i9.TableScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeWrapperPage: (data) {
      final args = data.getArgs<HomeWrapperPageArguments>(
        orElse: () => const HomeWrapperPageArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.HomeWrapperPage(key: args.key, langKey: args.langKey),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.LoginView(key: args.key, onResult: args.onResult),
        settings: data,
      );
    },
    _i4.SplashView: (data) {
      final args = data.getArgs<SplashViewArguments>(
        orElse: () => const SplashViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.SplashView(key: args.key),
        settings: data,
      );
    },
    _i5.SettingsView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.SettingsView(),
        settings: data,
      );
    },
    _i6.SyncResourcesView: (data) {
      final args = data.getArgs<SyncResourcesViewArguments>(
        orElse: () => const SyncResourcesViewArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.SyncResourcesView(key: args.key),
        settings: data,
      );
    },
    _i7.FormSubmissionScreen: (data) {
      final args = data.getArgs<FormSubmissionScreenArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.FormSubmissionScreen(
            key: args.key,
            submissionId: args.submissionId,
            formId: args.formId,
            versionId: args.versionId,
            assignmentId: args.assignmentId,
            currentPageIndex: args.currentPageIndex),
        settings: data,
      );
    },
    _i8.FormFlowBootstrapper: (data) {
      final args = data.getArgs<FormFlowBootstrapperArguments>(
        orElse: () => const FormFlowBootstrapperArguments(),
      );
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.FormFlowBootstrapper(
            key: args.key,
            submissionId: args.submissionId,
            formId: args.formId,
            versionId: args.versionId,
            assignmentId: args.assignmentId),
        settings: data,
      );
    },
    _i9.TableScreen: (data) {
      final args = data.getArgs<TableScreenArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.TableScreen(
            key: args.key,
            formId: args.formId,
            assignmentId: args.assignmentId),
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

  final _i10.Key? key;

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

  final _i10.Key? key;

  final dynamic Function(
    bool,
    _i11.UserSession?,
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

class SplashViewArguments {
  const SplashViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SplashViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SyncResourcesViewArguments {
  const SyncResourcesViewArguments({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SyncResourcesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FormSubmissionScreenArguments {
  const FormSubmissionScreenArguments({
    this.key,
    required this.submissionId,
    required this.formId,
    required this.versionId,
    this.assignmentId,
    this.currentPageIndex = 0,
  });

  final _i10.Key? key;

  final String submissionId;

  final String formId;

  final String versionId;

  final String? assignmentId;

  final int currentPageIndex;

  @override
  String toString() {
    return '{"key": "$key", "submissionId": "$submissionId", "formId": "$formId", "versionId": "$versionId", "assignmentId": "$assignmentId", "currentPageIndex": "$currentPageIndex"}';
  }

  @override
  bool operator ==(covariant FormSubmissionScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.submissionId == submissionId &&
        other.formId == formId &&
        other.versionId == versionId &&
        other.assignmentId == assignmentId &&
        other.currentPageIndex == currentPageIndex;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        submissionId.hashCode ^
        formId.hashCode ^
        versionId.hashCode ^
        assignmentId.hashCode ^
        currentPageIndex.hashCode;
  }
}

class FormFlowBootstrapperArguments {
  const FormFlowBootstrapperArguments({
    this.key,
    this.submissionId,
    this.formId,
    this.versionId,
    this.assignmentId,
  });

  final _i10.Key? key;

  final String? submissionId;

  final String? formId;

  final String? versionId;

  final String? assignmentId;

  @override
  String toString() {
    return '{"key": "$key", "submissionId": "$submissionId", "formId": "$formId", "versionId": "$versionId", "assignmentId": "$assignmentId"}';
  }

  @override
  bool operator ==(covariant FormFlowBootstrapperArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.submissionId == submissionId &&
        other.formId == formId &&
        other.versionId == versionId &&
        other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        submissionId.hashCode ^
        formId.hashCode ^
        versionId.hashCode ^
        assignmentId.hashCode;
  }
}

class TableScreenArguments {
  const TableScreenArguments({
    this.key,
    required this.formId,
    this.assignmentId,
  });

  final _i10.Key? key;

  final String formId;

  final String? assignmentId;

  @override
  String toString() {
    return '{"key": "$key", "formId": "$formId", "assignmentId": "$assignmentId"}';
  }

  @override
  bool operator ==(covariant TableScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.formId == formId &&
        other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ formId.hashCode ^ assignmentId.hashCode;
  }
}

extension NavigatorStateExtension on _i12.NavigationService {
  Future<dynamic> navigateToHomeWrapperPage({
    _i10.Key? key,
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
    _i10.Key? key,
    dynamic Function(
      bool,
      _i11.UserSession?,
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

  Future<dynamic> navigateToSplashView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.splashView,
        arguments: SplashViewArguments(key: key),
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

  Future<dynamic> navigateToSyncResourcesView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.syncResourcesView,
        arguments: SyncResourcesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFormSubmissionScreen({
    _i10.Key? key,
    required String submissionId,
    required String formId,
    required String versionId,
    String? assignmentId,
    int currentPageIndex = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.formSubmissionScreen,
        arguments: FormSubmissionScreenArguments(
            key: key,
            submissionId: submissionId,
            formId: formId,
            versionId: versionId,
            assignmentId: assignmentId,
            currentPageIndex: currentPageIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFormFlowBootstrapper({
    _i10.Key? key,
    String? submissionId,
    String? formId,
    String? versionId,
    String? assignmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.formFlowBootstrapper,
        arguments: FormFlowBootstrapperArguments(
            key: key,
            submissionId: submissionId,
            formId: formId,
            versionId: versionId,
            assignmentId: assignmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTableScreen({
    _i10.Key? key,
    required String formId,
    String? assignmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tableScreen,
        arguments: TableScreenArguments(
            key: key, formId: formId, assignmentId: assignmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeWrapperPage({
    _i10.Key? key,
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
    _i10.Key? key,
    dynamic Function(
      bool,
      _i11.UserSession?,
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

  Future<dynamic> replaceWithSplashView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.splashView,
        arguments: SplashViewArguments(key: key),
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

  Future<dynamic> replaceWithSyncResourcesView({
    _i10.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.syncResourcesView,
        arguments: SyncResourcesViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFormSubmissionScreen({
    _i10.Key? key,
    required String submissionId,
    required String formId,
    required String versionId,
    String? assignmentId,
    int currentPageIndex = 0,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.formSubmissionScreen,
        arguments: FormSubmissionScreenArguments(
            key: key,
            submissionId: submissionId,
            formId: formId,
            versionId: versionId,
            assignmentId: assignmentId,
            currentPageIndex: currentPageIndex),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFormFlowBootstrapper({
    _i10.Key? key,
    String? submissionId,
    String? formId,
    String? versionId,
    String? assignmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.formFlowBootstrapper,
        arguments: FormFlowBootstrapperArguments(
            key: key,
            submissionId: submissionId,
            formId: formId,
            versionId: versionId,
            assignmentId: assignmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTableScreen({
    _i10.Key? key,
    required String formId,
    String? assignmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tableScreen,
        arguments: TableScreenArguments(
            key: key, formId: formId, assignmentId: assignmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
