import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
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
        return Text(value ?? '', overflow: TextOverflow.ellipsis);
      },
      errorBuilder: (Object? error, StackTrace? st) => Text(
        'E',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.error),
      ),
    );
  }
}
