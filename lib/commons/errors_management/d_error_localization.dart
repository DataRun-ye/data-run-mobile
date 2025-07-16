import 'package:d_sdk/core/exception/exception.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:dio/dio.dart';

class ErrorMessage {
  const ErrorMessage();

  static String getMessage(Object? exception) {
    return switch (exception) {
      final DError error => _handleDError(error),
      final DException dException => _handleDException(dException),
      _ => S.current.unexpected(exception.toString().substring(0, 255)),
    };
  }

  static String _handleDError(DError d2Error) {
    final message = d2Error.message ?? d2Error.cause.toString();
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
      DRunErrorCode.noUserDetailsFetchedFromServer =>
        S.current.noUserDetailsFetchedFromServer(message),
      // DRunErrorCode.noLoggedInUserOffline =>
      //   S.current.noAuthenticatedUserOffline,
      DRunErrorCode.noActiveDatabaseInstance =>
        S.current.noActiveDatabaseFound(message),
      DRunErrorCode.systemFileError =>
        S.current.systemFilesAccessError(message),
      DRunErrorCode.unexpected => S.current.unexpected(message),
      null => S.current.unexpected(d2Error.toString()),
    };
  }

  static String _handleDException(DException dException) {
    if (dException.cause is DioException) {
      final dioException = dException.cause as DioException;
      return dioException.type.toPrettyDescription(dioException);
    }

    if (dException.cause is DError) {
      final d2Error = dException.cause as DError;
      return _handleDError(d2Error);
    }

    if (dException.cause is DException) {
      final d2Exception = dException.cause as DException;
      return _handleDException(d2Exception);
    }

    return dException.message ??
        dException.cause?.toString() ??
        dException.toString();
  }
}

extension DioExceptionTypeExtension on DioExceptionType {
  String toPrettyDescription(DioException e) {
    final errorMessage = e.message ?? '';
    final responseCode = e.response?.statusCode.toString() ?? '';
    final type = e.type.toString();
    final message = '$type: $responseCode $errorMessage';
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return S.current
            .connectionTimeout(DioExceptionType.connectionTimeout.name);
      case DioExceptionType.sendTimeout:
        return S.current.sendTimeout(DioExceptionType.sendTimeout.name);
      case DioExceptionType.receiveTimeout:
        return S.current.receiveTimeout(DioExceptionType.receiveTimeout.name);
      case DioExceptionType.badCertificate:
        return S.current.badCertificate(message);
      case DioExceptionType.badResponse:
        return S.current.badResponse(message);
      case DioExceptionType.cancel:
        return S.current.requestCancelled;
      case DioExceptionType.connectionError:
        return S.current.connectionError(message);
      case DioExceptionType.unknown:
        return S.current.unexpected(message);
    }
  }
}
