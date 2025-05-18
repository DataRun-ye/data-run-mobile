import 'package:datarunmobile/app_routes/app_routes.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/user_session/session_scope_initializer.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel()
      : this.form = FormGroup({
          'username': FormControl<String>(validators: [Validators.required]),
          'password': FormControl<String>(validators: [Validators.required]),
        });
  static const String URL_PATTERN =
      r'^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$';

  final FormGroup form;
  final AuthManager _authManager = appLocator<AuthManager>();
  final _router = appLocator<AppRouter>();

  Future<void> userLogin() async {
    FormControl<String> usernameControl =
        form.control('username') as FormControl<String>;

    FormControl<String> passwordControl =
        form.control('password') as FormControl<String>;

    form.markAsDisabled();
    try {
      final userDetails = await _authManager.login(
          username: usernameControl.value!, password: passwordControl.value!);
      // await appLocator<SessionScopeInitializer>().initAuthScope();

      await _router.replace(SyncProgressRoute());
      // _router.replace(HomeRoute());

      // _navigationService.replaceWithHomeScreen();
      // } else {
      //   _router.replace(HomeRoute());
      // }
      // await _navigationService.replaceWithSyncProgressView()

      // final SessionContext? session =
      //     await _sessionRepository.getActiveSession();
      // onResult?.call(true, session);
      // if (authResult.isSuccess()) {
      //   await init(authResult.getOrThrow());
      //   await _navigationService.replaceWithSyncProgressView();
      // } else {
      //   authResult.whenError((failure) => throw failure);
      // }
    } catch (e, s) {
      // if (appLocator.currentScopeName == 'authenticated') {
      //   await _scopeInitializer.popScope();
      // }
      // onResult?.call(false, null);
      // await _router.replace(LoginRoute());
      // await appLocator<SessionScopeInitializer>().popAuthScope();

      form.markAsEnabled();
      usernameControl.markAsEnabled();
      passwordControl.markAsEnabled();
      debugPrintStack(stackTrace: s);
      DExceptionReporter.instance.report(e, showToUser: true);
      rethrow;
    }
  }
}
