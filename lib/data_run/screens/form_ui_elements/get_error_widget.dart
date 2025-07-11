import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:flutter/material.dart';

Widget getErrorWidget(Object? error, StackTrace? stackTrace) {
  logError('error: $error');
  debugPrintStack(stackTrace: stackTrace, label: error.toString());
  return Builder(builder: (context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        color: cs.errorContainer,
        child: Text(
          'Error $error',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: cs.error),
        ),
      ),
    );
  });
}
