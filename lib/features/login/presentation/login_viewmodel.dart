import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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

  final NavigationService _navigationService = appLocator<NavigationService>();

  Future<void> userLogin() async {
    FormControl<String> usernameControl =
        form.control('username') as FormControl<String>;

    FormControl<String> passwordControl =
        form.control('password') as FormControl<String>;

    form.markAsDisabled();
    try {
      final userDetails = await _authManager.login(
          username: usernameControl.value!, password: passwordControl.value!);
      _navigationService.replaceWithSyncResourcesView();
    } catch (e, s) {
      form.markAsEnabled();
      usernameControl.markAsEnabled();
      passwordControl.markAsEnabled();
      logError('couldn\'t login', stackTrace: s);
      DExceptionReporter.instance.report(e, showToUser: true);
    }
  }
}
