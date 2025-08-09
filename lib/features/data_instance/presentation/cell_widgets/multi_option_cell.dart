import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form/presentation/widgets/value_type_value_display.dart';
import 'package:flutter/material.dart';

class MultiOptionCell extends StatelessWidget {
  const MultiOptionCell({
    super.key,
    this.optionIds,
  });

  final Object? optionIds;

  @override
  Widget build(BuildContext context) {
    return ValueTypeValueDisplay(
        valueType: ValueType.SelectMulti, value: optionIds);
  }
}
