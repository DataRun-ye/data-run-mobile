import 'package:d_sdk/user_session/session_context.dart';
import 'package:datarunmobile/data/password_visibility.provider.dart';
import 'package:datarunmobile/features/login/presentation/login_view_header.dart';
import 'package:datarunmobile/features/login/presentation/login_view_submit_button.dart';
import 'package:datarunmobile/features/login/presentation/login_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key, this.onResult}) : super(key: key);

  final Function(bool didLogin, SessionContext? context)? onResult;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Consumer(
          builder: (
            BuildContext context,
            WidgetRef ref,
            Widget? child,
          ) {
            final isPasswordObscured = ref.watch(passwordVisibilityProvider);
            final username =
                viewModel.form.control('username') as FormControl<String>;
            final password =
                viewModel.form.control('password') as FormControl<String>;
            // final language =
            // ref.watch(preferenceNotifierProvider(Preference.language));
            // final currentAuthUser = viewModel.user;
            final cs = Theme.of(context).colorScheme;
            return ReactiveForm(
              formGroup: viewModel.form,
              child: SafeArea(
                child: Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(-0.5, -0.6),
                        radius: 0.15,
                        colors: <Color>[cs.onPrimary, cs.primary],
                        // colors: <Color>[cs.onPrimary, cs.primary],
                        stops: <double>[0.4, 0.8],
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
                                  formControl:
                                      viewModel.form.control('username')
                                          as FormControl<String>,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).username,
                                    prefixIcon:
                                        Icon(Icons.person, color: cs.primary),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Password input with visibility toggle
                                ReactiveTextField<String>(
                                  formControl: password,
                                  obscureText: isPasswordObscured,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).password,
                                    prefixIcon:
                                        Icon(Icons.lock, color: cs.primary),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isPasswordObscured
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: cs.primary,
                                      ),
                                      onPressed: () {
                                        ref
                                            .read(passwordVisibilityProvider
                                                .notifier)
                                            .toggle();
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: LoginViewSubmitButton(
                                    onPressed: () => viewModel.userLogin(),
                                    // if (result.success) {
                                    //   Navigator.of(context).pushReplacement(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => AuthSyncWrapper(
                                    //             isAuthenticated: result.success,
                                    //             needsSync: true)),
                                    //   );
                                    // }
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
          },
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
