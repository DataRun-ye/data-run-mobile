import 'package:flutter/material.dart';

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('indigo', Colors.indigo),
  blue('blue', Colors.blue),
  teal('teal', Colors.teal),
  green('green', Colors.green),
  yellow('yellow', Colors.yellow),
  orange('orange', Colors.orange),
  deepOrange('deepOrange', Colors.deepOrange),
  ;

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}
