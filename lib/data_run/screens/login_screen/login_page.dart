import 'package:datarun/app/app.locator.dart';
import 'package:datarun/data_run/screens/login_screen/auth_wrapper.dart';
import 'package:datarun/data_run/screens/login_screen/login_header.dart';
import 'package:datarun/data_run/screens/login_screen/login_submit_button.dart';
import 'package:datarun/data_run/screens/login_screen/reactive_form_state/login_reactive_form_model.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => true);

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormModel = locator<LoginReactiveFormModel>();

    final isPasswordObscured = ref.watch(passwordVisibilityProvider);

    return ReactiveForm(
      formGroup: loginFormModel.form,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
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
                        horizontal: 20, vertical: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LoginHeader(),
                        SizedBox(height: 24),
                        Text(
                          S.of(context).login,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 24),
                        ReactiveTextField<String>(
                          onTapOutside: loginFormModel.serverUrlControl.hasFocus
                              ? (event) =>
                                  loginFormModel.serverUrlControl.unfocus()
                              : null,
                          formControl: loginFormModel.serverUrlControl,
                          decoration: InputDecoration(
                            labelText: S.of(context).serverUrl,
                            prefixIcon: Icon(Icons.link,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(height: 16),
                        ReactiveTextField<String>(
                          onTapOutside: loginFormModel.usernameControl.hasFocus
                              ? (event) =>
                                  loginFormModel.usernameControl.unfocus()
                              : null,
                          formControl: loginFormModel.usernameControl,
                          decoration: InputDecoration(
                            labelText: S.of(context).username,
                            prefixIcon: Icon(Icons.person,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Password input with visibility toggle
                        ReactiveTextField<String>(
                          formControl: loginFormModel.passwordControl,
                          obscureText: isPasswordObscured,
                          decoration: InputDecoration(
                            labelText: S.of(context).password,
                            prefixIcon: Icon(Icons.lock,
                                color: Theme.of(context).primaryColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                ref
                                    .read(passwordVisibilityProvider.notifier)
                                    .state = !isPasswordObscured;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: LoginSubmitButton(
                            onPressed: () async {
                              final result = await loginFormModel.login();
                              if (result.success) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => AuthSyncWrapper(
                                          isAuthenticated: result.success,
                                          needsSync: true)),
                                );
                              }
                            },
                          ),
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
