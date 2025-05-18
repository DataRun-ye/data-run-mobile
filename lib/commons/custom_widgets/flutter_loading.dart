import 'package:flutter/material.dart';

class FlutterLoading extends StatelessWidget {
  const FlutterLoading({
    super.key,
    required this.isLoading,
    required this.childBuilder,
    this.color = Colors.blue,
  });

  final bool isLoading;
  final Widget Function() childBuilder;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.only(top: isLoading ? 10.0 : 0),
            child: childBuilder.call(),
          );
  }
}
