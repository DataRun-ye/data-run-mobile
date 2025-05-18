import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:flutter/material.dart';

Widget getErrorWidget(Object? error, StackTrace? stackTrace,
    {String? message}) {
  logError('error: $error');
  debugPrintStack(stackTrace: stackTrace, label: error.toString());
  return Builder(builder: (context) {
    return Center(
      child: Text(
        'Error $error ${message != null ? message : ''}',
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Colors.red),
      ),
    );
  });
}
