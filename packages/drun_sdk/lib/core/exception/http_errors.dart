import 'package:d_sdk/core/exception/exception.dart';
import 'package:dio/dio.dart';

class RevokeTokenException extends DioException {
  RevokeTokenException({required super.requestOptions});
}

class NetworkHttpError extends NetworkException {
  NetworkHttpError._(
    String message, {
    String? url,
    bool shouldShowMessage = true,
    DErrorComponent? errorComponent = DErrorComponent.Server,
    super.httpErrorCode,
    super.cause,
    super.stackTrace,
    required super.errorCode,
  }) : super(message,
            shouldShowMessage: shouldShowMessage,
            url: url,
            errorComponent: errorComponent);

  factory NetworkHttpError.error(Response? response,
          {StackTrace? stackTrace}) =>
      switch (response) {
        Response(:final statusCode) when statusCode == 200 =>
          NetworkHttpError._('Bad request',
              url: response.requestOptions.path,
              httpErrorCode: response.statusCode,
              errorCode: DRunErrorCode.badRequest,
              stackTrace: stackTrace,
              cause: response),
        Response(:final statusCode) when statusCode == 401 =>
          NetworkHttpError._('unauthorized',
              url: response.requestOptions.path,
              httpErrorCode: response.statusCode,
              errorCode: DRunErrorCode.unauthorized,
              stackTrace: stackTrace,
              cause: response),
        Response(:final statusCode) when statusCode == 403 =>
          NetworkHttpError._('forbidden',
              url: response.requestOptions.path,
              httpErrorCode: response.statusCode,
              errorCode: DRunErrorCode.forbidden,
              stackTrace: stackTrace,
              cause: response),
        Response(:final statusCode) when statusCode == 404 =>
          NetworkHttpError._('not found',
              url: response.requestOptions.path,
              httpErrorCode: response.statusCode,
              errorCode: DRunErrorCode.notFound,
              stackTrace: stackTrace,
              cause: response),
        _ => NetworkHttpError._('http server Error',
            url: response?.requestOptions.path,
            httpErrorCode: response?.statusCode,
            errorCode: DRunErrorCode.unexpected,
            stackTrace: stackTrace,
            cause: response),
      };

  factory NetworkHttpError.fromDioException(DioException error,
      {StackTrace? stackTrace}) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        NetworkHttpError._(error.message ?? 'Connection timeout',
            url: error.requestOptions.path,
            httpErrorCode: error.response?.statusCode,
            errorCode: DRunErrorCode.networkTimeout,
            stackTrace: stackTrace,
            cause: error.error),
      DioExceptionType.badResponse => NetworkHttpError._(
          error.message ?? 'Bad response',
          url: error.requestOptions.path,
          httpErrorCode: error.response?.statusCode,
          errorCode: DRunErrorCode.networkConnectionFailed,
          stackTrace: stackTrace,
          cause: error.error),
      DioExceptionType.cancel => NetworkHttpError._(error.message ?? 'Cancel',
          shouldShowMessage: false,
          url: error.requestOptions.path,
          httpErrorCode: error.response?.statusCode,
          errorCode: DRunErrorCode.unexpected,
          stackTrace: stackTrace,
          cause: error.error),
      DioExceptionType.connectionError => NetworkHttpError._(
          error.message ?? 'Bad Response',
          url: error.requestOptions.path,
          httpErrorCode: error.response?.statusCode,
          errorCode: DRunErrorCode.badResponse,
          stackTrace: stackTrace,
          cause: error.error),
      DioExceptionType.badCertificate => NetworkHttpError._(
          error.message ?? 'Bad Http Certificate',
          url: error.requestOptions.path,
          httpErrorCode: error.response?.statusCode,
          errorCode: DRunErrorCode.badCertificate,
          stackTrace: stackTrace,
          cause: error.error),
      DioExceptionType.unknown =>
        NetworkHttpError.error(error.response, stackTrace: stackTrace),
    };
  }
}
