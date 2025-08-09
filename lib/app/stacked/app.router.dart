// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:d_sdk/core/user_session/user_session.dart' as _i14;
import 'package:datarunmobile/features/assignment/presentation/assignment_screen.dart'
    as _i7;
import 'package:datarunmobile/features/data_instance/presentation/table_screen.dart'
    as _i12;
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart'
    as _i15;
import 'package:datarunmobile/features/form_submission/presentation/form_flow_bootstrapper.dart'
    as _i11;
import 'package:datarunmobile/features/form_submission/presentation/form_submission_screen.widget.dart'
    as _i10;
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_panel.dart'
    as _i17;
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_screen.dart'
    as _i8;
import 'package:datarunmobile/features/form_submission/presentation/submission_history_screen.dart'
    as _i9;
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
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart' as _i16;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i18;

class Routes {
  static const homeWrapperPage = '/home-wrapper-page';

  static const loginView = '/login-view';

  static const splashView = '/splash-view';

  static const settingsView = '/settings-view';

  static const syncResourcesView = '/sync-resources-view';

  static const assignmentScreen = '/assignment-screen';

  static const editRowScreen = '/edit-row-screen';

  static const submissionHistoryScreen = '/submission-history-screen';

  static const formSubmissionScreen = '/form-submission-screen';

  static const formFlowBootstrapper = '/form-flow-bootstrapper';

  static const tableScreen = '/table-screen';

  static const all = <String>{
    homeWrapperPage,
    loginView,
    splashView,
    settingsView,
    syncResourcesView,
    assignmentScreen,
    editRowScreen,
    submissionHistoryScreen,
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
      Routes.assignmentScreen,
      page: _i7.AssignmentScreen,
    ),
    _i1.RouteDef(
      Routes.editRowScreen,
      page: _i8.EditRowScreen,
    ),
    _i1.RouteDef(
      Routes.submissionHistoryScreen,
      page: _i9.SubmissionHistoryScreen,
    ),
    _i1.RouteDef(
      Routes.formSubmissionScreen,
      page: _i10.FormSubmissionScreen,
    ),
    _i1.RouteDef(
      Routes.formFlowBootstrapper,
      page: _i11.FormFlowBootstrapper,
    ),
    _i1.RouteDef(
      Routes.tableScreen,
      page: _i12.TableScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeWrapperPage: (data) {
      final args = data.getArgs<HomeWrapperPageArguments>(
        orElse: () => const HomeWrapperPageArguments(),
      );
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i2.HomeWrapperPage(key: args.key, langKey: args.langKey),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i3.LoginView(key: args.key, onResult: args.onResult),
        settings: data,
      );
    },
    _i4.SplashView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SplashView(),
        settings: data,
      );
    },
    _i5.SettingsView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.SettingsView(),
        settings: data,
      );
    },
    _i6.SyncResourcesView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.SyncResourcesView(),
        settings: data,
      );
    },
    _i7.AssignmentScreen: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.AssignmentScreen(),
        settings: data,
      );
    },
    _i8.EditRowScreen: (data) {
      final args = data.getArgs<EditRowScreenArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.EditRowScreen(
            repeatInstance: args.repeatInstance,
            item: args.item,
            title: args.title,
            onRemoveItem: args.onRemoveItem,
            onSave: args.onSave),
        settings: data,
      );
    },
    _i9.SubmissionHistoryScreen: (data) {
      final args =
          data.getArgs<SubmissionHistoryScreenArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.SubmissionHistoryScreen(
            key: args.key, form: args.form, assignment: args.assignment),
        settings: data,
      );
    },
    _i10.FormSubmissionScreen: (data) {
      final args = data.getArgs<FormSubmissionScreenArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.FormSubmissionScreen(
            key: args.key,
            submissionId: args.submissionId,
            formId: args.formId,
            versionId: args.versionId,
            assignmentId: args.assignmentId,
            currentPageIndex: args.currentPageIndex),
        settings: data,
      );
    },
    _i11.FormFlowBootstrapper: (data) {
      final args = data.getArgs<FormFlowBootstrapperArguments>(
        orElse: () => const FormFlowBootstrapperArguments(),
      );
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.FormFlowBootstrapper(
            key: args.key,
            submissionId: args.submissionId,
            formId: args.formId,
            versionId: args.versionId,
            assignmentId: args.assignmentId),
        settings: data,
      );
    },
    _i12.TableScreen: (data) {
      final args = data.getArgs<TableScreenArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.TableScreen(
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

  final _i13.Key? key;

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

  final _i13.Key? key;

  final dynamic Function(
    bool,
    _i14.UserSession?,
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

class EditRowScreenArguments {
  const EditRowScreenArguments({
    required this.repeatInstance,
    required this.item,
    this.title,
    this.onRemoveItem,
    required this.onSave,
  });

  final _i15.RepeatSection repeatInstance;

  final _i15.RepeatItemInstance item;

  final String? title;

  final void Function(_i15.RepeatItemInstance)? onRemoveItem;

  final void Function(
    _i16.FormGroup,
    _i17.EditActionType,
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

  final _i13.Key? key;

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

class FormSubmissionScreenArguments {
  const FormSubmissionScreenArguments({
    this.key,
    required this.submissionId,
    required this.formId,
    required this.versionId,
    this.assignmentId,
    this.currentPageIndex = 0,
  });

  final _i13.Key? key;

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

  final _i13.Key? key;

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

  final _i13.Key? key;

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

extension NavigatorStateExtension on _i18.NavigationService {
  Future<dynamic> navigateToHomeWrapperPage({
    _i13.Key? key,
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
    _i13.Key? key,
    dynamic Function(
      bool,
      _i14.UserSession?,
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

  Future<dynamic> navigateToEditRowScreen({
    required _i15.RepeatSection repeatInstance,
    required _i15.RepeatItemInstance item,
    String? title,
    void Function(_i15.RepeatItemInstance)? onRemoveItem,
    required void Function(
      _i16.FormGroup,
      _i17.EditActionType,
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
    _i13.Key? key,
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

  Future<dynamic> navigateToFormSubmissionScreen({
    _i13.Key? key,
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
    _i13.Key? key,
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
    _i13.Key? key,
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
    _i13.Key? key,
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
    _i13.Key? key,
    dynamic Function(
      bool,
      _i14.UserSession?,
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

  Future<dynamic> replaceWithEditRowScreen({
    required _i15.RepeatSection repeatInstance,
    required _i15.RepeatItemInstance item,
    String? title,
    void Function(_i15.RepeatItemInstance)? onRemoveItem,
    required void Function(
      _i16.FormGroup,
      _i17.EditActionType,
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
    _i13.Key? key,
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

  Future<dynamic> replaceWithFormSubmissionScreen({
    _i13.Key? key,
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
    _i13.Key? key,
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
    _i13.Key? key,
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
