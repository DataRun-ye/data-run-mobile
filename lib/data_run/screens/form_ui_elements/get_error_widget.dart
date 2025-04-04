import 'package:flutter/material.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';

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
