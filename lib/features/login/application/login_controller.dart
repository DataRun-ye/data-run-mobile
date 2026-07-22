import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/logging/new_app_logging.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginController {
  LoginController({
    required AuthManager authManager,
    required NavigationService navigationService,
  })  : _authManager = authManager,
        _navigationService = navigationService;

  final AuthManager _authManager;
  final NavigationService _navigationService;
  final FormGroup form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  Future<void> userLogin() => _login(useDemoCredentials: false);

  Future<void> demoLogin() => _login(useDemoCredentials: true);

  Future<void> _login({required bool useDemoCredentials}) async {
    final username = form.control('username') as FormControl<String>;
    final password = form.control('password') as FormControl<String>;

    if (useDemoCredentials) {
      username.updateValue('test1234');
      password.updateValue('test1234');
    }

    form.markAsDisabled();
    try {
      await _authManager.login(
        username: username.value!,
        password: password.value!,
      );
      _navigationService.replaceWithSyncResourcesView();
    } catch (error, stackTrace) {
      form.markAsEnabled();
      if (useDemoCredentials) {
        username.updateValue(null);
        password.updateValue(null);
      }
      username.markAsEnabled();
      password.markAsEnabled();
      logError('couldn\'t login', stackTrace: stackTrace);
      DExceptionReporter.instance.report(error, showToUser: true);
    }
  }

  void dispose() => form.dispose();
}
