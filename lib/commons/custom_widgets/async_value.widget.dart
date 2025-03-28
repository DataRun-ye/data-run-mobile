import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// Generic AsyncValueWidget to work with values of type T
class AsyncValueWidgetWithOverLay<T> extends StatelessWidget {
  const AsyncValueWidgetWithOverLay(
      {super.key, required this.value, required this.valueBuilder});

  // input async value
  final AsyncValue<T> value;

  // output builder function
  final Widget Function(T) valueBuilder;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: AsyncValueWidget(value: value, valueBuilder: valueBuilder),
    );
    // return switch (value) {
    //   AsyncValue(error: final error?, stackTrace: final stackTrace) =>
    //     getErrorWidget(error, stackTrace),
    //   AsyncValue(valueOrNull: final valueOrNull?) =>
    //     valueBuilder.call(valueOrNull),
    //   _ => const LoadingIndicator(
    //       indicatorType: Indicator.ballPulse,
    //
    //       /// Required, The loading type of the widget
    //       colors: [Colors.white],
    //
    //       /// Optional, The color collections
    //       strokeWidth: 2,
    //
    //       /// Optional, The stroke of the line, only applicable to widget which contains line
    //       backgroundColor: Colors.black,
    //
    //       /// Optional, Background of the widget
    //       pathBackgroundColor: Colors.black
    //
    //       /// Optional, the stroke backgroundColor
    //       ),
    // };
  }
}

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key, required this.value, required this.valueBuilder});

  // input async value
  final AsyncValue<T> value;

  // output builder function
  final Widget Function(T) valueBuilder;

  @override
  Widget build(BuildContext context) {
    if (value.hasError || value.hasValue) context.loaderOverlay.hide();
    if (value.isLoading) context.loaderOverlay.show();

    if (value.hasValue) return valueBuilder.call(value.value!);

    return const SizedBox.shrink();

    // return switch (value) {
    //   AsyncValue(error: final error?, stackTrace: final stackTrace) =>
    //       getErrorWidget(error, stackTrace),
    //   AsyncValue(valueOrNull: final valueOrNull?) =>
    //       valueBuilder.call(valueOrNull),
    //   _ => const LoadingIndicator(
    //       indicatorType: Indicator.ballPulse,
    //
    //       /// Required, The loading type of the widget
    //       colors: [Colors.white],
    //
    //       /// Optional, The color collections
    //       strokeWidth: 2,
    //
    //       /// Optional, The stroke of the line, only applicable to widget which contains line
    //       backgroundColor: Colors.black,
    //
    //       /// Optional, Background of the widget
    //       pathBackgroundColor: Colors.black
    //
    //     /// Optional, the stroke backgroundColor
    //   ),
    // };
  }
}
