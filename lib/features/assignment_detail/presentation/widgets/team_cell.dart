import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form/presentation/widgets/value_type_value_display.dart';
import 'package:flutter/material.dart';

class TeamCell extends StatelessWidget {
  const TeamCell(
      {super.key, required this.team, this.row = false, this.size = 25});

  final String? team;
  final bool row;
  final double size;

  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(Icons.group, size: size),
      row ? SizedBox(width: 4) : SizedBox.shrink(),
      ValueTypeValueDisplay(valueType: ValueType.SelectMulti, value: team),
    ];
    return row
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: items,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: items,
          );
  }
}
