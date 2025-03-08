import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';
import 'package:datarun/app/di/injection.dart';
import 'package:datarun/commons/constants.dart';
import 'package:datarun/commons/errors_management/d_exception_reporter.dart';
import 'package:datarun/core/auth/auth_service.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/modular/account/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

@lazySingleton
class LoginReactiveFormModel {
  LoginReactiveFormModel(this._authService, this.userSessionManager);

  static String URL_PATTERN =
      r'^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$';

  final AuthService _authService;
  final UserSessionManager userSessionManager;

  final FormGroup form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
    'serverUrl': FormControl<String>(
        validators: [Validators.pattern(URL_PATTERN)], disabled: true),
  });

  FormControl<String> get usernameControl =>
      form.control('username') as FormControl<String>;

  FormControl<String> get passwordControl =>
      form.control('password') as FormControl<String>;

  FormControl<String> get serverUrlControl =>
      form.control('serverUrl') as FormControl<String>;

  Future<AuthenticationResult> login() async {
    form.markAsDisabled();
    final authResult = AuthenticationResult();
    try {
      final authResult = await _authService.login(usernameControl.value!,
          passwordControl.value!, serverUrlControl.value ?? kApiBaseUrl);

      if (authResult.success) {
        // save UserCredentials to preference
        await userSessionManager.saveUserCredentials(
            serverUrl: authResult.sessionUser!.baseUrl,
            username: authResult.sessionUser!.username!,
            pass: authResult.sessionUser!.password!);

        registerUser(UserModel.fromJson(authResult.sessionUser!.toJson()));
        // return successful result
        return authResult.copyWith(
            success: true, sessionUser: authResult.sessionUser);
      }
    } catch (e) {
      usernameControl.markAsEnabled();
      passwordControl.markAsEnabled();
      userSessionManager.clearSessionFromPreferences();
      DExceptionReporter.instance.report(e, showToUser: true);
    }
    return authResult.copyWith(
        success: false, sessionUser: authResult.sessionUser);
  }
}
