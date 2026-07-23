import 'package:datarunmobile/core/exception/d_error.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';
import 'package:datarunmobile/core/exception/d_exception.dart';
import 'package:datarunmobile/core/exception/failure_snapshot.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/exception/server_failure.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:dio/dio.dart';

class ErrorMessage {
  const ErrorMessage();

  static String getMessage(Object? exception) {
    return switch (exception) {
      final DioException error => _handleDError(
          NetworkHttpError.fromDioException(error),
        ),
      final FailureSnapshot failure => _handleFailure(
          failure.errorCode,
          failure.serverFailure,
        ),
      final DError error => _handleDError(error),
      final DException dException => _handleDException(dException),
      _ => S.current.generalErrorTitle,
    };
  }

  static String _handleDError(DError error) {
    final serverFailure =
        error is NetworkHttpError ? error.serverFailure : null;
    return _handleFailure(error.errorCode, serverFailure);
  }

  static String _handleFailure(
    DRunErrorCode? errorCode,
    ServerFailure? serverFailure,
  ) {
    final domainMessage = _serverFailureMessage(serverFailure);
    final serverMessage = serverFailure?.detail;
    return switch (errorCode) {
      DRunErrorCode.validationError =>
        domainMessage ?? S.current.validationError,
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
        domainMessage ?? serverMessage ?? S.current.validationError,
      DRunErrorCode.notFound => domainMessage ?? S.current.generalErrorTitle,
      DRunErrorCode.serverError => S.current.generalErrorTitle,
      DRunErrorCode.unauthorized => S.current.authSessionExpired,
      DRunErrorCode.forbidden => domainMessage ?? S.current.generalErrorTitle,
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

  static String? _serverFailureMessage(ServerFailure? failure) {
    return switch (failure?.code?.toUpperCase()) {
      'E3000' => S.current.authSessionExpired,
      'E3001' ||
      'E3002' ||
      'E3003' ||
      'E3004' ||
      'E3005' =>
        S.current.permissionDenied,
      'E3006' => S.current.submissionTeamUnavailable,
      'E4110' || 'E4111' => S.current.submissionRejected,
      'E4112' => S.current.submissionFormMissing,
      'E4113' => S.current.submissionTeamMissing,
      'E4114' => S.current.submissionTeamAccessDenied,
      'E4115' => S.current.submissionFormVersionConflict,
      'E4116' => S.current.submissionNotFound,
      _ => null,
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
