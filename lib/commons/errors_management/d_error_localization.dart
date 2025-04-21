import 'package:d_sdk/core/exception/d_error.dart';
import 'package:d_sdk/core/exception/d_error_code.dart';
import 'package:datarunmobile/generated/l10n.dart';

class ErrorMessage {
  const ErrorMessage();

  static String getMessage(Object? exception) {
    return switch (exception) {
      final DError error => _handleDError(error),
      // final DException dException => _handleDException(dException.c),
      _ => S.current.unexpected(exception.toString().substring(0, 20)),
    };
  }

  static String _handleDError(DError d2Error) {
    final message = d2Error.message ?? '';
    return switch (d2Error.errorCode) {
      DRunErrorCode.validationError => S.current.validationError,
      DRunErrorCode.networkTimeout => S.current.networkTimeout,
      DRunErrorCode.networkConnectionFailed =>
        S.current.networkConnectionFailed,
      DRunErrorCode.invalidCredentials => S.current.authInvalidCredentials,
      DRunErrorCode.accountDisabled => S.current.accountDisabled,
      DRunErrorCode.databaseConnectionFailed =>
        S.current.databaseConnectionFailed,
      DRunErrorCode.databaseQueryFailed => S.current.databaseQueryFailed,
      DRunErrorCode.databaseInternalError =>
        S.current.databaseInternalError(message),
      DRunErrorCode.apiError => S.current.apiError(message),
      DRunErrorCode.syncError => S.current.syncError(message),
      DRunErrorCode.badResponse => S.current.badHttpRequest(message),
      DRunErrorCode.badRequest => S.current.badRequestToEndPoint(message),
      DRunErrorCode.notFound => S.current.endPointNotFound(message),
      DRunErrorCode.serverError => S.current.serverError(message),
      DRunErrorCode.unauthorized =>
        S.current.unauthorizedAccessToEndPoint(message),
      DRunErrorCode.forbidden => S.current.forbidden(message),
      DRunErrorCode.invalidData => S.current.invalidData(message),
      DRunErrorCode.badCertificate => S.current.badCertificate(message),
      DRunErrorCode.sessionExpired => S.current.sessionExpired(message),
      DRunErrorCode.noLoggedInUser => S.current.noAuthenticatedUser,
      DRunErrorCode.noLoggedInUserOffline =>
        S.current.noAuthenticatedUserOffline,
      DRunErrorCode.noActiveDatabaseInstance =>
        S.current.noActiveDatabaseFound(message),
      DRunErrorCode.unexpected => S.current.unexpected(message),
      null => S.current.unexpected(d2Error.toString()),
    };
  }
}
