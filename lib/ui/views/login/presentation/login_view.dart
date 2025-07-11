import 'package:d_sdk/user_session/session_context.dart';
import 'package:datarunmobile/data/password_visibility.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/ui/views/login/presentation/login_viewmodel.dart';
import 'package:datarunmobile/ui/views/login/presentation/widgets/login_view_header.dart';
import 'package:datarunmobile/ui/views/login/presentation/widgets/login_view_submit_button.dart';
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
            return ReactiveForm(
              formGroup: viewModel.form,
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
                                const LoginViewHeader(),
                                const SizedBox(height: 24),
                                Text(
                                  S.of(context).login,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color:
                                            Theme.of(context).primaryColorDark,
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
                                    prefixIcon: Icon(Icons.person,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Password input with visibility toggle
                                ReactiveTextField<String>(
                                  formControl: password,
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
