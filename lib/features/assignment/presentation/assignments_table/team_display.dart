import 'package:d_sdk/database/shared/shared.dart';
import 'package:flutter/material.dart';

class TeamDisplay extends StatelessWidget {
  const TeamDisplay(
      {super.key, required this.team, this.row = false, this.size = 25});

  final IdentifiableModel team;
  final bool row;
  final double size;

  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(Icons.group, size: size),
      row ? SizedBox(width: 4) : SizedBox.shrink(),
      Text(team.code ?? ''),
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
