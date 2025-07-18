import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/network/if_online_abstract.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginViewSubmitButton extends ConsumerWidget {
  const LoginViewSubmitButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ReactiveForm.of(context);
    final formIsValid = form!.valid;
    final isOnlineAsync = ref.watch(isOnlineProvider);

    return AsyncValueWidget(
      value: isOnlineAsync,
      valueBuilder: (bool isOnline) => FilledButton(
        child: isOnline
            ? Text(S.of(context).login)
            : Text(S.of(context).noConnection),
        onPressed: isOnline && formIsValid ? onPressed : null,
      ),
    );
  }
}
