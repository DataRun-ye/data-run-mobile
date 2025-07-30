import 'package:flutter/material.dart';

class NumericCell extends StatelessWidget {
  const NumericCell({super.key, this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value ?? '',
      textAlign: TextAlign.center,
    );
  }
}
