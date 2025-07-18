import 'package:datarunmobile/features/form_ui_elements/presentation/get_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic AsyncValueWidget to work with values of type T
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key,
      required this.value,
      required this.valueBuilder,
      this.isLoadingBuilder});

  // input async value
  final AsyncValue<T> value;

  // output builder function
  final Widget Function(T) valueBuilder;
  final Widget Function()? isLoadingBuilder;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncValue(error: final error?, stackTrace: final stackTrace) =>
        getErrorWidget(error, stackTrace),
      AsyncValue(valueOrNull: final valueOrNull?) =>
        valueBuilder.call(valueOrNull),
      AsyncValue() => isLoadingBuilder != null
          ? isLoadingBuilder!.call()
          : Center(child: const CircularProgressIndicator()),
    };
  }
}
