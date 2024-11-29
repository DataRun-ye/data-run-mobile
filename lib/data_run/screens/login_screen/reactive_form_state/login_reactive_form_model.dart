import 'package:datarun/commons/constants.dart';
import 'package:datarun/commons/errors_management/d_exception_reporter.dart';
import 'package:datarun/core/auth/auth_service.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_reactive_form_model.g.dart';

@riverpod
LoginReactiveFormModel loginReactiveFormModel(LoginReactiveFormModelRef ref) {
  return LoginReactiveFormModel(
      ref.watch(authServiceProvider), ref.watch(userSessionManagerProvider));
}

class LoginReactiveFormModel {
  static String URL_PATTERN =
      r'^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$';

  LoginReactiveFormModel(this._authService, this.userSessionManager)
      : this.form = FormGroup({
          'username': FormControl<String>(validators: [Validators.required]),
          'password': FormControl<String>(validators: [Validators.required]),
          'serverUrl': FormControl<String>(
              validators: [Validators.pattern(URL_PATTERN)], disabled: true),
        });

  final AuthService _authService;
  final UserSessionManager userSessionManager;

  final FormGroup form;

  FormControl<String> get usernameControl =>
      form.control('username') as FormControl<String>;

  FormControl<String> get passwordControl =>
      form.control('password') as FormControl<String>;

  FormControl<String> get serverUrlControl =>
      form.control('serverUrl') as FormControl<String>;

  Future<bool> login() async {
    form.markAsDisabled();
    try {
      final result = await _authService.login(usernameControl.value!,
          passwordControl.value!, serverUrlControl.value ?? kApiBaseUrl);
      return result.success;
    } catch (e) {
      form.markAsEnabled();
      userSessionManager.clearSessionFromPreferences();
      DExceptionReporter.instance.report(e, showToUser: true);
      return false;
    }
  }
}
