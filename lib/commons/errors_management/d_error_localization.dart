import 'package:d2_remote/core/datarun/exception/d_error.dart';
import 'package:d2_remote/core/datarun/exception/d_error_code.dart';
import 'package:datarunmobile/generated/l10n.dart';

class ErrorMessage {
  const ErrorMessage();

  static String getMessage(Object? exception) {
    return switch (exception) {
      final DError error => _handleDError(error),
      // final DException dException => _handleDException(dException.c),
      _ => S.current.unknownError(exception.toString().substring(0, 20)),
    };
  }

  static String _handleDError(DError d2Error) {
    return switch (d2Error.errorCode) {
      DErrorCode.validationError => S.current.validationError,
      DErrorCode.authInvalidCredentials => S.current.authInvalidCredentials,
      DErrorCode.networkTimeout => S.current.networkTimeout,
      DErrorCode.networkConnectionFailed => S.current.networkConnectionFailed,
      DErrorCode.authSessionExpired => S.current.authSessionExpired,
      DErrorCode.noAuthenticatedUser => S.current.noAuthenticatedUser,
      DErrorCode.noAuthenticatedUserOffline =>
        S.current.noAuthenticatedUserOffline,
      DErrorCode.differentOfflineUser => S.current.differentOfflineUser,
      DErrorCode.accountDisabled => S.current.accountDisabled,
      DErrorCode.databaseConnectionFailed => S.current.databaseConnectionFailed,
      DErrorCode.databaseQueryFailed => S.current.databaseQueryFailed,
      DErrorCode.databaseInternalError =>
        S.current.databaseInternalError(d2Error.message),
      DErrorCode.apiError => S.current.apiError(d2Error.message),
      DErrorCode.syncError => S.current.syncError(d2Error.message),
      DErrorCode.unknownError => S.current.unknownError(d2Error.message),
    };
  }
}
