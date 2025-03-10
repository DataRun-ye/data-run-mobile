import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/screens/form_ui_elements/get_error_widget.dart';

/// Generic AsyncValueWidget to work with values of type T
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key, required this.value, required this.valueBuilder});

  // input async value
  final AsyncValue<T> value;

  // output builder function
  final Widget Function(T) valueBuilder;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncValue(error: final error?, stackTrace: final stackTrace) =>
        getErrorWidget(error, stackTrace),
      AsyncValue(valueOrNull: final valueOrNull?) =>
        valueBuilder.call(valueOrNull),
      _ => const CircularProgressIndicator(),
    };
  }
}
