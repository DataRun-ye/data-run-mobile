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
        S.current.databaseInternalError(d2Error.message),
      DRunErrorCode.apiError => S.current.apiError(d2Error.message),
      DRunErrorCode.syncError => S.current.syncError(d2Error.message),
      DRunErrorCode.unexpected => S.current.unexpected(d2Error.message),
      DRunErrorCode.badResponse => S.current.badHttpRequest(d2Error.message),
      DRunErrorCode.badRequest =>
        S.current.badRequestToEndPoint(d2Error.message),
      DRunErrorCode.notFound => S.current.endPointNotFound(d2Error.message),
      DRunErrorCode.serverError => S.current.serverError(d2Error.message),
      DRunErrorCode.unauthorized =>
        S.current.unauthorizedAccessToEndPoint(d2Error.message),
      DRunErrorCode.forbidden => S.current.forbidden(d2Error.message),
      DRunErrorCode.invalidData => S.current.invalidData(d2Error.message),
      DRunErrorCode.badCertificate => S.current.badCertificate(d2Error.message),
      DRunErrorCode.sessionExpired => S.current.sessionExpired(d2Error.message),
      DRunErrorCode.noLoggedInUser => S.current.noAuthenticatedUser,
      DRunErrorCode.noLoggedInUserOffline =>
        S.current.noAuthenticatedUserOffline,
      DRunErrorCode.noActiveDatabaseInstance =>
        S.current.noActiveDatabaseFound(d2Error.message),
    };
  }
}
