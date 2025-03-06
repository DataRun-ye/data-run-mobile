import 'package:d2_remote/core/datarun/exception/exception.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarun/commons/errors_management/d_error_localization.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:datarun/utils/navigator_key.dart';
import 'package:flutter/material.dart';

class DExceptionReporter {

  DExceptionReporter._internal();
  static DExceptionReporter instance = DExceptionReporter._internal();

  void report(Object? error, {bool showToUser = false}) {
    final message = ErrorMessage.getMessage(error);

    logException(DException(error.toString(), error));

    if (showToUser) {
      _showUserAlert(message);
    }
  }

  Future<void> _showUserAlert(String message) {
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text('An Error Occurred'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.ok),
          ),
        ],
      ),
    );
  }
}
