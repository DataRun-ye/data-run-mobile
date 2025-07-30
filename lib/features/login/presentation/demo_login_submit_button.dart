import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/network/if_online_abstract.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DemoLoginSubmitButton extends ConsumerWidget {
  const DemoLoginSubmitButton({
    super.key,
    this.onPressed,
    required this.label,
  });

  final String label;
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
            ? Text(label)
            : Text(S.of(context).noConnection),
        onPressed: isOnline && form.enabled ? onPressed : null,
      ),
    );
  }
}
