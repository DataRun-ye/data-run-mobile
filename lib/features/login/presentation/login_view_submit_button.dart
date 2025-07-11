import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginViewSubmitButton extends StatelessWidget {
  const LoginViewSubmitButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    final formIsValid = form!.valid;
    return FilledButton(
      child: Text(S.of(context).login),
      onPressed: formIsValid ? onPressed : null,
    );
  }
}
