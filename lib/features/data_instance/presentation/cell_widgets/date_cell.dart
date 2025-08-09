import 'package:flutter/material.dart';

class DateCell extends StatelessWidget {
  const DateCell({this.date});

  final String? date;

  @override
  Widget build(BuildContext context) {
    return Text(date ?? '', overflow: TextOverflow.ellipsis);
  }
}
