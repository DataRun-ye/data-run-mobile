// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/core/user_session/user_session.dart' as _i13;
import 'package:datarunmobile/app/app_routes/app_router.dart' as _i9;
import 'package:datarunmobile/features/assignment/presentation/assignment_screen.dart'
    as _i7;
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_view.dart'
    as _i8;
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart'
    as _i14;
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_panel.dart'
    as _i16;
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_screen.dart'
    as _i10;
import 'package:datarunmobile/features/form_submission/presentation/submission_history_screen.dart'
    as _i11;
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
import 'package:flutter/material.dart' as _i12;
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart' as _i15;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i17;

class Routes {
  static const homeWrapperPage = '/home-wrapper-page';

  static const loginView = '/login-view';

  static const splashView = '/splash-view';

  static const settingsView = '/settings-view';

  static const syncResourcesView = '/sync-resources-view';

  static const assignmentScreen = '/assignment-screen';

  static const assignmentDetailView = '/assignment-detail-view';

  static const assignmentDetailPage = '/assignment-detail-page';

  static const editRowScreen = '/edit-row-screen';

  static const submissionHistoryScreen = '/submission-history-screen';

  static const all = <String>{
    homeWrapperPage,
    loginView,
    splashView,
    settingsView,
    syncResourcesView,
    assignmentScreen,
    assignmentDetailView,
    assignmentDetailPage,
    editRowScreen,
    submissionHistoryScreen,
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
      Routes.assignmentScreen,
      page: _i7.AssignmentScreen,
    ),
    _i1.RouteDef(
      Routes.assignmentDetailView,
      page: _i8.AssignmentDetailView,
    ),
    _i1.RouteDef(
      Routes.assignmentDetailPage,
      page: _i9.AssignmentDetailPage,
    ),
    _i1.RouteDef(
      Routes.editRowScreen,
      page: _i10.EditRowScreen,
    ),
    _i1.RouteDef(
      Routes.submissionHistoryScreen,
      page: _i11.SubmissionHistoryScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeWrapperPage: (data) {
      final args = data.getArgs<HomeWrapperPageArguments>(
        orElse: () => const HomeWrapperPageArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.HomeWrapperPage(key: args.key, langKey: args.langKey),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.LoginView(key: args.key, onResult: args.onResult),
        settings: data,
      );
    },
    _i4.SplashView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SplashView(),
        settings: data,
      );
    },
    _i5.SettingsView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.SettingsView(),
        settings: data,
      );
    },
    _i6.SyncResourcesView: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.SyncResourcesView(),
        settings: data,
      );
    },
    _i7.AssignmentScreen: (data) {
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.AssignmentScreen(),
        settings: data,
      );
    },
    _i8.AssignmentDetailView: (data) {
      final args = data.getArgs<AssignmentDetailViewArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.AssignmentDetailView(
            key: args.key, assignmentId: args.assignmentId),
        settings: data,
      );
    },
    _i9.AssignmentDetailPage: (data) {
      final args = data.getArgs<AssignmentDetailPageArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.AssignmentDetailPage(id: args.id),
        settings: data,
      );
    },
    _i10.EditRowScreen: (data) {
      final args = data.getArgs<EditRowScreenArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.EditRowScreen(
            repeatInstance: args.repeatInstance,
            item: args.item,
            title: args.title,
            onRemoveItem: args.onRemoveItem,
            onSave: args.onSave),
        settings: data,
      );
    },
    _i11.SubmissionHistoryScreen: (data) {
      final args =
          data.getArgs<SubmissionHistoryScreenArguments>(nullOk: false);
      return _i12.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.SubmissionHistoryScreen(
            key: args.key, form: args.form, assignment: args.assignment),
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
    _i13.UserSession?,
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

class AssignmentDetailViewArguments {
  const AssignmentDetailViewArguments({
    this.key,
    required this.assignmentId,
  });

  final _i12.Key? key;

  final String assignmentId;

  @override
  String toString() {
    return '{"key": "$key", "assignmentId": "$assignmentId"}';
  }

  @override
  bool operator ==(covariant AssignmentDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.assignmentId == assignmentId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ assignmentId.hashCode;
  }
}

class AssignmentDetailPageArguments {
  const AssignmentDetailPageArguments({required this.id});

  final String id;

  @override
  String toString() {
    return '{"id": "$id"}';
  }

  @override
  bool operator ==(covariant AssignmentDetailPageArguments other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class EditRowScreenArguments {
  const EditRowScreenArguments({
    required this.repeatInstance,
    required this.item,
    this.title,
    this.onRemoveItem,
    required this.onSave,
  });

  final _i14.RepeatSection repeatInstance;

  final _i14.RepeatItemInstance item;

  final String? title;

  final void Function(_i14.RepeatItemInstance)? onRemoveItem;

  final void Function(
    _i15.FormGroup,
    _i16.EditActionType,
  ) onSave;

  @override
  String toString() {
    return '{"repeatInstance": "$repeatInstance", "item": "$item", "title": "$title", "onRemoveItem": "$onRemoveItem", "onSave": "$onSave"}';
  }

  @override
  bool operator ==(covariant EditRowScreenArguments other) {
    if (identical(this, other)) return true;
    return other.repeatInstance == repeatInstance &&
        other.item == item &&
        other.title == title &&
        other.onRemoveItem == onRemoveItem &&
        other.onSave == onSave;
  }

  @override
  int get hashCode {
    return repeatInstance.hashCode ^
        item.hashCode ^
        title.hashCode ^
        onRemoveItem.hashCode ^
        onSave.hashCode;
  }
}

class SubmissionHistoryScreenArguments {
  const SubmissionHistoryScreenArguments({
    this.key,
    required this.form,
    this.assignment,
  });

  final _i12.Key? key;

  final String form;

  final String? assignment;

  @override
  String toString() {
    return '{"key": "$key", "form": "$form", "assignment": "$assignment"}';
  }

  @override
  bool operator ==(covariant SubmissionHistoryScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.form == form &&
        other.assignment == assignment;
  }

  @override
  int get hashCode {
    return key.hashCode ^ form.hashCode ^ assignment.hashCode;
  }
}

extension NavigatorStateExtension on _i17.NavigationService {
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

  Future<dynamic> navigateToLoginView({
    _i12.Key? key,
    dynamic Function(
      bool,
      _i13.UserSession?,
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

  Future<dynamic> navigateToAssignmentScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.assignmentScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAssignmentDetailView({
    _i12.Key? key,
    required String assignmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.assignmentDetailView,
        arguments:
            AssignmentDetailViewArguments(key: key, assignmentId: assignmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAssignmentDetailPage({
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.assignmentDetailPage,
        arguments: AssignmentDetailPageArguments(id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditRowScreen({
    required _i14.RepeatSection repeatInstance,
    required _i14.RepeatItemInstance item,
    String? title,
    void Function(_i14.RepeatItemInstance)? onRemoveItem,
    required void Function(
      _i15.FormGroup,
      _i16.EditActionType,
    ) onSave,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editRowScreen,
        arguments: EditRowScreenArguments(
            repeatInstance: repeatInstance,
            item: item,
            title: title,
            onRemoveItem: onRemoveItem,
            onSave: onSave),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSubmissionHistoryScreen({
    _i12.Key? key,
    required String form,
    String? assignment,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.submissionHistoryScreen,
        arguments: SubmissionHistoryScreenArguments(
            key: key, form: form, assignment: assignment),
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

  Future<dynamic> replaceWithLoginView({
    _i12.Key? key,
    dynamic Function(
      bool,
      _i13.UserSession?,
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

  Future<dynamic> replaceWithAssignmentScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.assignmentScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAssignmentDetailView({
    _i12.Key? key,
    required String assignmentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.assignmentDetailView,
        arguments:
            AssignmentDetailViewArguments(key: key, assignmentId: assignmentId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAssignmentDetailPage({
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.assignmentDetailPage,
        arguments: AssignmentDetailPageArguments(id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditRowScreen({
    required _i14.RepeatSection repeatInstance,
    required _i14.RepeatItemInstance item,
    String? title,
    void Function(_i14.RepeatItemInstance)? onRemoveItem,
    required void Function(
      _i15.FormGroup,
      _i16.EditActionType,
    ) onSave,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editRowScreen,
        arguments: EditRowScreenArguments(
            repeatInstance: repeatInstance,
            item: item,
            title: title,
            onRemoveItem: onRemoveItem,
            onSave: onSave),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSubmissionHistoryScreen({
    _i12.Key? key,
    required String form,
    String? assignment,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.submissionHistoryScreen,
        arguments: SubmissionHistoryScreenArguments(
            key: key, form: form, assignment: assignment),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
