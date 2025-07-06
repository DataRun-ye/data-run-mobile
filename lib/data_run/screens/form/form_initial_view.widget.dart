import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormInitialView extends HookConsumerWidget {
  const FormInitialView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Placeholder(),
    );
  }
}
