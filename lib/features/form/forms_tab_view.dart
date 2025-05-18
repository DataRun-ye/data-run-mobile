import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FormsTabView extends StatelessWidget {
  FormsTabView({
    super.key,
    required this.activity,
    required this.assignment,
  });

  final String assignment;
  final String activity;

  // final List<FormVersionModel> forms;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
