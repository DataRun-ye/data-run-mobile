import 'package:flutter/widgets.dart';

/// A Wrap that always has at least the full screen width (or any
/// provided maxWidth), so it only wraps children when it
/// genuinely runs out of room—never prematurely because of
/// some narrow parent.
///
/// Usage:
/// ```dart
/// FullWidthWrap(
///   spacing: 8,
///   runSpacing: 4,
///   children: [ ... ],
/// )
/// ```
class FullWidthWrap extends StatelessWidget {
  const FullWidthWrap({
    Key? key,
    this.spacing = 8.0,
    this.runSpacing = 4.0,
    required this.children,
  }) : super(key: key);

  /// Horizontal space between items.
  final double spacing;

  /// Vertical space between runs.
  final double runSpacing;

  /// The widgets to lay out.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 400;

    return isNarrow
        ? Wrap(
            spacing: 8,
            runSpacing: 4,
            children: children,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          );
  }
}
