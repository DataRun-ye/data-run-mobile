import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:datarunmobile/data/password_visibility.provider.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:datarunmobile/features/login/application/login_controller.dart';
import 'package:datarunmobile/features/login/presentation/demo_login_submit_button.dart';
import 'package:datarunmobile/features/login/presentation/login_view_header.dart';
import 'package:datarunmobile/features/login/presentation/login_view_submit_button.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key, this.onResult});

  final Function(bool didLogin, UserSession? context)? onResult;

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final LoginController _controller = LoginController(
    authManager: appLocator<AuthManager>(),
    navigationService: appLocator<NavigationService>(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordObscured = ref.watch(passwordVisibilityProvider);
    final username =
        _controller.form.control('username') as FormControl<String>;
    final password =
        _controller.form.control('password') as FormControl<String>;
    final cs = Theme.of(context).colorScheme;

    return ReactiveForm(
      formGroup: _controller.form,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [cs.primary, cs.onPrimary],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LoginViewHeader(),
                        const SizedBox(height: 40),
                        Text(
                          S.of(context).login,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: cs.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 24),
                        ReactiveTextField<String>(
                          onTapOutside: username.hasFocus
                              ? (event) => username.unfocus()
                              : null,
                          formControl: username,
                          decoration: InputDecoration(
                            labelText: S.of(context).username,
                            prefixIcon: Icon(Icons.person, color: cs.primary),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ReactiveTextField<String>(
                          formControl: password,
                          obscureText: isPasswordObscured,
                          decoration: InputDecoration(
                            labelText: S.of(context).password,
                            prefixIcon: Icon(Icons.lock, color: cs.primary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: cs.primary,
                              ),
                              onPressed: () => ref
                                  .read(passwordVisibilityProvider.notifier)
                                  .toggle(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            LoginViewSubmitButton(
                              onPressed: _controller.userLogin,
                              label: S.of(context).login,
                            ),
                            if (AppEnvironment.isDev)
                              DemoLoginSubmitButton(
                                onPressed: _controller.demoLogin,
                                label: S.of(context).demoLogin,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
