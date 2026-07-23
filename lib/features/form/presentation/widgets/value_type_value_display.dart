import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/commons/errors_management/d_error_localization.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form/application/value_display.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValueTypeValueDisplay extends ConsumerWidget {
  const ValueTypeValueDisplay({super.key, required this.valueType, this.value});

  final ValueType valueType;
  final Object? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final valueAsync =
        ref.watch(valueDisplayProvider(valueType: valueType, value: value));
    return AsyncValueWidget(
      value: valueAsync,
      valueBuilder: (String? value) {
        return Tooltip(
          message: value,
          child: Text(value ?? '', overflow: TextOverflow.ellipsis),
        );
      },
      errorBuilder: (Object? error, StackTrace? st) => Tooltip(
        message: ErrorMessage.getMessage(error),
        child: Icon(
          Icons.error_outline,
          size: 16,
          color: cs.error,
        ),
      ),
    );
  }
}
