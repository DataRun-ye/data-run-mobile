import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCell extends StatelessWidget {
  const DateCell({this.date, this.dateFormat});

  final DateTime? date;
  final DateFormat? dateFormat;

  @override
  Widget build(BuildContext context) {
    final effectiveDateFormat = dateFormat ?? DateFormat.yMMMMd().add_jm();
    final value = effectiveDateFormat.format(date!);
    return Tooltip(
        message: value,
        child: Text(
          value,
          overflow: TextOverflow.ellipsis,
        ));
  }
}
