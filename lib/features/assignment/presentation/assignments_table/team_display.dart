import 'package:d_sdk/database/shared/shared.dart';
import 'package:flutter/material.dart';

class TeamDisplay extends StatelessWidget {
  const TeamDisplay({
    super.key,
    required this.team,
    this.row = false,
  });

  final IdentifiableModel team;
  final bool row;

  @override
  Widget build(BuildContext context) {
    final items = [
      const Icon(Icons.group),
      row ? SizedBox(width: 4,) : SizedBox.shrink(),
      Text('${team.code}'),
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
