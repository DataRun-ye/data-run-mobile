import 'package:d_sdk/core/exception/d_error.dart';

import 'd_error_code.dart';

class SessionInitException extends DError {
  SessionInitException(
      {String? message, Exception? cause, StackTrace? stackTrace})
      : super(
            message: "Failed to init user session ${message ?? ''}",
            cause: cause,
            stackTrace: stackTrace,
            errorComponent: DErrorComponent.SDK,
            errorCode: DRunErrorCode.databaseConnectionFailed);
}
