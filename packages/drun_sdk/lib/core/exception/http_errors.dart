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

  factory NetworkHttpError.error(Response? response, {StackTrace? stackTrace, Object? cause}) {
    String message = '${response?.statusMessage ?? ''}' +
        ' ${response?.data.toString() ?? ''}';
    message = message.length > 600 ? message.substring(0, 600) : message;

    return switch (response) {
      Response(:final statusCode) when statusCode == 200 => NetworkHttpError._(
          'Bad request: ${message}',
          url: response.requestOptions.path,
          httpErrorCode: response.statusCode,
          errorCode: DRunErrorCode.badRequest,
          stackTrace: stackTrace,
          cause: cause),
      Response(:final statusCode) when statusCode == 401 => NetworkHttpError._(
          'unauthorized: ${message}',
          url: response.requestOptions.path,
          httpErrorCode: response.statusCode,
          errorCode: DRunErrorCode.unauthorized,
          stackTrace: stackTrace,
          cause: cause),
      Response(:final statusCode) when statusCode == 403 => NetworkHttpError._(
          'forbidden: ${message}',
          url: response.requestOptions.path,
          httpErrorCode: response.statusCode,
          errorCode: DRunErrorCode.forbidden,
          stackTrace: stackTrace,
          cause: cause),
      Response(:final statusCode) when statusCode == 404 => NetworkHttpError._(
          'not found: ${message}',
          url: response.requestOptions.path,
          httpErrorCode: response.statusCode,
          errorCode: DRunErrorCode.notFound,
          stackTrace: stackTrace,
          cause: cause),
      Response(:final statusCode) when statusCode == 406 => NetworkHttpError._(
          'invalid, not acceptable request: ${message}',
          url: response.requestOptions.path,
          httpErrorCode: response.statusCode,
          errorCode: DRunErrorCode.notFound,
          stackTrace: stackTrace,
          cause: cause),
      _ => NetworkHttpError._('http server Error: ${message}',
          url: response?.requestOptions.path,
          httpErrorCode: response?.statusCode,
          errorCode: DRunErrorCode.unexpected,
          stackTrace: stackTrace,
          cause: cause),
    };
  }

  factory NetworkHttpError.fromDioException(DioException error,
      {StackTrace? stackTrace}) {
    String message = '${error.response?.statusMessage ?? ''}' +
        // ' ${error.response?.data.toString() ?? ''}' +
        ' ${error.message}';
    message = message.length > 600 ? message.substring(0, 600) : message;

    // error.
    return NetworkHttpError.error(error.response, stackTrace: stackTrace, cause: error);
    // return switch (error.type) {
    //   DioExceptionType.connectionTimeout ||
    //   DioExceptionType.receiveTimeout ||
    //   DioExceptionType.sendTimeout =>
    //     NetworkHttpError._('Connection timeout: ${message}',
    //         url: error.requestOptions.path,
    //         httpErrorCode: error.response?.statusCode,
    //         errorCode: DRunErrorCode.networkTimeout,
    //         stackTrace: stackTrace,
    //         cause: error),
    //   DioExceptionType.badResponse => NetworkHttpError._(
    //       'Bad response: ${message}',
    //       url: error.requestOptions.path,
    //       httpErrorCode: error.response?.statusCode,
    //       errorCode: DRunErrorCode.networkConnectionFailed,
    //       stackTrace: stackTrace,
    //       cause: error),
    //   DioExceptionType.cancel => NetworkHttpError._(
    //       'Request Canceled ${message}',
    //       shouldShowMessage: false,
    //       url: error.requestOptions.path,
    //       httpErrorCode: error.response?.statusCode,
    //       errorCode: DRunErrorCode.unexpected,
    //       stackTrace: stackTrace,
    //       cause: error),
    //   DioExceptionType.connectionError => NetworkHttpError._(
    //       'Connection To server error: ${message}',
    //       url: error.requestOptions.path,
    //       httpErrorCode: error.response?.statusCode,
    //       errorCode: DRunErrorCode.badResponse,
    //       stackTrace: stackTrace,
    //       cause: error),
    //   DioExceptionType.badCertificate => NetworkHttpError._(
    //       'Bad Http Certificate: ${message}',
    //       url: error.requestOptions.path,
    //       httpErrorCode: error.response?.statusCode,
    //       errorCode: DRunErrorCode.badCertificate,
    //       stackTrace: stackTrace,
    //       cause: error),
    //   DioExceptionType.unknown =>
    //     NetworkHttpError.error(error.response, stackTrace: stackTrace),
    // };
  }
}
