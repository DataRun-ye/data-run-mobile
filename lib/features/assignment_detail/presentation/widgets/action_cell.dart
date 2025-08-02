import 'package:flutter/material.dart';

class ActionCell extends StatelessWidget {
  const ActionCell(
      {super.key, required this.onPressed, required this.icon, this.tooltip});

  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;

  @override
  Widget build(BuildContext c) => IconButton(
        icon: icon,
        onPressed: onPressed,
        tooltip: tooltip,
      );
}
