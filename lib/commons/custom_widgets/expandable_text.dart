import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 2,
  });

  final String text;
  final int trimLines;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;
    final TextSpan textSpan =
        TextSpan(text: widget.text, style: defaultTextStyle);
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    final bool showSeeMore = textPainter.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.text,
          maxLines: _isExpanded ? null : widget.trimLines,
          overflow: TextOverflow.fade, // or TextOverflow.ellipsis
        ),
        if (showSeeMore)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Show Less' : 'Show More',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
      ],
    );
  }
// @override
// Widget build(BuildContext context) {
//   final theme = Theme.of(context).textTheme.bodySmall!;
//   final color = Theme.of(context).colorScheme.primary;
//
//   return LayoutBuilder(builder: (context, constraints) {
//     final span = TextSpan(text: widget.text, style: theme);
//     final tp = TextPainter(
//       text: span,
//       maxLines: widget.maxLines,
//       textDirection: TextDirection.ltr,
//     )..layout(maxWidth: constraints.maxWidth);
//
//     final isOverflowing = tp.didExceedMaxLines;
//
//     return AnimatedSize(
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeInOut,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.text,
//             style: theme,
//             maxLines: _expanded ? null : widget.maxLines,
//             overflow: TextOverflow.fade,
//           ),
//           if (isOverflowing)
//             GestureDetector(
//               onTap: () => setState(() => _expanded = !_expanded),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 4.0),
//                 child: Text(
//                   _expanded ? S.of(context).showLess : S.of(context).showMore,
//                   style: theme.copyWith(
//                     color: color,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   });
// }
}
