import 'package:flutter/material.dart';

class TableHeaderLabel extends StatelessWidget {
  const TableHeaderLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
