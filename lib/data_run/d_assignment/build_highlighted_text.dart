import 'package:flutter/material.dart';

Widget buildHighlightedText(
    String text, String searchQuery, BuildContext context,
    {TextStyle? style}) {
  if (searchQuery.isEmpty) {
    return Text(text, style: style,);
  }

  final matches = RegExp(searchQuery, caseSensitive: false).allMatches(text);
  if (matches.isEmpty) {
    return Text(text);
  }

  final List<TextSpan> spans = [];
  int start = 0;

  for (final match in matches) {
    if (match.start > start) {
      spans.add(TextSpan(text: text.substring(start, match.start), style: style));
    }
    spans.add(TextSpan(
      text: text.substring(match.start, match.end),
      style: style?.merge(TextStyle(backgroundColor: Theme.of(context).primaryColorLight)),
    ));
    start = match.end;
  }

  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start), style: style));
  }

  return RichText(
    text: TextSpan(style: DefaultTextStyle.of(context).style, children: spans),
  );
}
