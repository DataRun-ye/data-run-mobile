import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HighlightedByValueLabel extends ConsumerWidget {
  const HighlightedByValueLabel(
    this.text,
    this.searchQuery, {
    super.key,
    this.style,
  });

  final String text;
  final String searchQuery;
  final TextStyle? style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchQuery.isEmpty) {
      return Text(
        text,
        style: style,
      );
    }

    final matches = RegExp(searchQuery, caseSensitive: false).allMatches(text);
    if (matches.isEmpty) {
      return Text(
        text,
        overflow: TextOverflow.ellipsis,
      );
    }

    final List<TextSpan> spans = [];
    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: style != null
            ? style?.merge(
                TextStyle(backgroundColor: Theme.of(context).primaryColorLight))
            : TextStyle(backgroundColor: Theme.of(context).primaryColorLight),
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: style));
    }

    return RichText(
      text:
          TextSpan(style: DefaultTextStyle.of(context).style, children: spans),
    );
  }
}
