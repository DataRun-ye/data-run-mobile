import 'package:datarunmobile/core/exception/d_error.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';
import 'package:datarunmobile/core/exception/d_exception.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:dio/dio.dart';

class ErrorMessage {
  const ErrorMessage();

  static String getMessage(Object? exception) {
    return switch (exception) {
      final DioException error => _handleDError(
          NetworkHttpError.fromDioException(error),
        ),
      final DError error => _handleDError(error),
      final DException dException => _handleDException(dException),
      _ => S.current.generalErrorTitle,
    };
  }

  static String _handleDError(DError error) {
    final serverMessage =
        error is NetworkHttpError ? error.serverMessage : null;
    return switch (error.errorCode) {
      DRunErrorCode.validationError => S.current.validationError,
      DRunErrorCode.networkTimeout => S.current.networkTimeout,
      DRunErrorCode.networkConnectionFailed =>
        S.current.networkConnectionFailed,
      DRunErrorCode.invalidCredentials => S.current.authInvalidCredentials,
      DRunErrorCode.accountDisabled => S.current.accountDisabled,
      DRunErrorCode.databaseConnectionFailed =>
        S.current.databaseConnectionFailed,
      DRunErrorCode.databaseQueryFailed => S.current.databaseQueryFailed,
      DRunErrorCode.databaseInternalError => S.current.generalErrorTitle,
      DRunErrorCode.apiError => S.current.generalErrorTitle,
      DRunErrorCode.syncError => S.current.syncFailed,
      DRunErrorCode.badResponse => S.current.generalErrorTitle,
      DRunErrorCode.badRequest ||
      DRunErrorCode.invalidData =>
        serverMessage ?? S.current.validationError,
      DRunErrorCode.notFound => S.current.generalErrorTitle,
      DRunErrorCode.serverError => S.current.generalErrorTitle,
      DRunErrorCode.unauthorized => S.current.authSessionExpired,
      DRunErrorCode.forbidden => S.current.generalErrorTitle,
      DRunErrorCode.badCertificate => S.current.generalErrorTitle,
      DRunErrorCode.sessionExpired => S.current.authSessionExpired,
      DRunErrorCode.noLoggedInUser => S.current.noAuthenticatedUser,
      DRunErrorCode.noUserDetailsFetchedFromServer =>
        S.current.noAuthenticatedUser,
      DRunErrorCode.noActiveDatabaseInstance =>
        S.current.databaseConnectionFailed,
      DRunErrorCode.systemFileError => S.current.generalErrorTitle,
      DRunErrorCode.unexpected => S.current.generalErrorTitle,
      null => S.current.generalErrorTitle,
    };
  }

  static String _handleDException(DException dException) {
    final cause = dException.cause;
    if (cause != null && !identical(cause, dException)) {
      return getMessage(cause);
    }
    return S.current.generalErrorTitle;
  }
}
