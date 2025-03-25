import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';
import 'package:datarunmobile/app/app.router.dart';
import 'package:datarunmobile/app/app_environment.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/services/auth.service.dart';
import 'package:datarunmobile/core/services/user_session_manager.service.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class LoginReactiveFormViewModel {
  LoginReactiveFormViewModel(
      this._authService, this._userSessionManager, this._navigationService)
      : this.form = FormGroup({
          'username': FormControl<String>(validators: [Validators.required]),
          'password': FormControl<String>(validators: [Validators.required]),
        });

  static String URL_PATTERN =
      r'^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$';

  final AuthService _authService;
  final UserSessionService _userSessionManager;
  final NavigationService _navigationService;

  final FormGroup form;

  Future<void> login() async {
    FormControl<String> usernameControl =
        form.control('username') as FormControl<String>;

    FormControl<String> passwordControl =
        form.control('password') as FormControl<String>;

    form.markAsDisabled();
    final authResult = const AuthenticationResult();
    try {
      final authResult = await _authService.login(
          usernameControl.value!, passwordControl.value!, AppEnvironment.apiBaseUrl);

      if (authResult.success) {
        // save UserCredentials to preference
        await _userSessionManager.saveUserCredentials(
            serverUrl: authResult.sessionUser!.baseUrl,
            username: authResult.sessionUser!.username!,
            langKey: authResult.sessionUser?.langKey);

        // return successful result
        // if (authResult.sessionUser != null) {
        //   registerUser(UserModel.fromJson(authResult.sessionUser!.toJson()));
        // }
        await _navigationService.replaceWithSyncScreen();
        // return authResult.copyWith(
        //     success: true, sessionUser: authResult.sessionUser);
      }
    } catch (e) {
      usernameControl.markAsEnabled();
      passwordControl.markAsEnabled();
      _userSessionManager.clearSessionFromPreferences();
      if (authResult.sessionUser != null) {
        unregisterLogin();
      }
      DExceptionReporter.instance.report(e, showToUser: true);
      rethrow;
    }
    // return authResult.copyWith(
    //     success: false, sessionUser: authResult.sessionUser);
  }
}
