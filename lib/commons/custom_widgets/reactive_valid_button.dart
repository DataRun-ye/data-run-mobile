import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveValidButton extends StatelessWidget {
  const ReactiveValidButton({
    super.key,
    required this.label,
    required this.color,
    this.onPressed,
    this.icon,
    this.toolTip = '',
  });

  final Widget? icon;
  final Widget label;
  final String toolTip;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    if (icon != null) {
      return Tooltip(
          message: toolTip,
          child: ElevatedButton.icon(
            onPressed: form!.valid ? onPressed : null,
            label: label,
            icon: icon,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shadowColor: Theme.of(context).colorScheme.shadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ));
    }

    return FilledButton(
      child: label,
      onPressed: form!.valid ? onPressed : null,
    );
  }
}
