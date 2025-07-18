import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:flutter/material.dart';

class HighlightedLabelWithIcon extends StatelessWidget {
  const HighlightedLabelWithIcon(
    this.icon,
    this.text,
    this.searchQuery, {
    super.key,
    this.style,
  });

  final IconData? icon;
  final String text;

  final String searchQuery;

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      spacing: 2,
      overflowSpacing: 2,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 4),
        HighlightedByValueLabel(text, searchQuery, style: style)
      ],
    );
  }
}
