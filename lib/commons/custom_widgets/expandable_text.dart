import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 2,
  });

  final String text;
  final int maxLines;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodySmall!;
    final color = Theme.of(context).colorScheme.primary;

    return LayoutBuilder(builder: (context, constraints) {
      final span = TextSpan(text: widget.text, style: theme);
      final tp = TextPainter(
        text: span,
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: constraints.maxWidth);

      final isOverflowing = tp.didExceedMaxLines;

      return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: theme,
              maxLines: _expanded ? null : widget.maxLines,
              overflow: TextOverflow.fade,
            ),
            if (isOverflowing)
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _expanded ? 'عرض أقل' : 'عرض المزيد',
                    style: theme.copyWith(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
