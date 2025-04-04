import 'package:flutter/material.dart';

class FlutterLoading extends StatelessWidget {
  const FlutterLoading({
    super.key,
    required this.isLoading,
    required this.child,
    this.color = Colors.blue,
  });

  final bool isLoading;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: isLoading ? 10.0 : 0),
          child: child,
        ),
        if (isLoading)
          Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: LinearProgressIndicator(
              color: color,
            ),
          ),
      ],
    );
  }
}
