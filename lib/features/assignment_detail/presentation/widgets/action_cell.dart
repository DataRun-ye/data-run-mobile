import 'package:flutter/material.dart';

class ActionCell extends StatelessWidget {
  const ActionCell({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext c) =>
      IconButton(icon: icon, onPressed: onPressed);
}
