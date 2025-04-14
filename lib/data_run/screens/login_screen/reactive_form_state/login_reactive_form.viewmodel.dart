import 'package:d_sdk/auth/auth_manager.dart';
import 'package:d_sdk/core/config/app_environment_instance.dart';
import 'package:d_sdk/core/config/server_config.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class LoginReactiveFormViewModel {
  LoginReactiveFormViewModel(this._navigationService)
      : this.form = FormGroup({
          'username': FormControl<String>(validators: [Validators.required]),
          'password': FormControl<String>(validators: [Validators.required]),
        });

  static String URL_PATTERN =
      r'^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$';

  final NavigationService _navigationService;
  final AuthManager _authManager = DSdk.authManager;

  // final UserSessionRepository _userSessionRepository =
  //     DSdk.userSessionRepository;

  final FormGroup form;

  Future<void> login() async {
    FormControl<String> usernameControl =
        form.control('username') as FormControl<String>;

    FormControl<String> passwordControl =
        form.control('password') as FormControl<String>;

    form.markAsDisabled();
    try {
      // final Result<User, AuthenticationException> authResult =
      await _authManager.authenticate(
          username: usernameControl.value!,
          password: passwordControl.value!,
          server: ServerConfig(AppEnvironment.apiBaseUrl));


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
      usernameControl.markAsEnabled();
      passwordControl.markAsEnabled();
      debugPrintStack(stackTrace: s);
      DExceptionReporter.instance.report(e, showToUser: true);
    }
  }

// Future<void> init(User userAuthData) async {
//   final currentUser = AuthenticatedUser.fromMap(
//       {...userAuthData.toJson(), 'baseUrl': AppEnvironment.apiBaseUrl});
//   await _userSessionRepository.cacheCurrentAuthUserData(currentUser);
//   _scopeInitializer.initScope(currentUser);
//   _scopeInitializer.registerAuthUser(authUser: currentUser);
//   return DSdk.dbManager.saveAuthUserData(userAuthData);
// }
}
