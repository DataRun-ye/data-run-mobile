import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form/presentation/widgets/value_type_value_display.dart';
import 'package:flutter/material.dart';

class OptionCell extends StatelessWidget {
  const OptionCell({
    super.key,
    required this.optionId,
  });

  final String? optionId;

  @override
  Widget build(BuildContext context) {
    return ValueTypeValueDisplay(
      valueType: ValueType.SelectOne,
      value: optionId,
    );
  }
}
