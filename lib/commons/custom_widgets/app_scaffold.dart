import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),
      body: child,
    );
  }
}
