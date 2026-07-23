import 'package:datarunmobile/core/exception/d_error_code.dart';
import 'package:datarunmobile/core/exception/network_exceptions.dart';
import 'package:dio/dio.dart';

class RevokeTokenException extends DioException {
  RevokeTokenException({required super.requestOptions});
}

class NetworkHttpError extends NetworkException {
  NetworkHttpError._(
    String message, {
    String? url,
    this.serverMessage,
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

  factory NetworkHttpError.error(
    Response<dynamic>? response, {
    StackTrace? stackTrace,
    Object? cause,
    DRunErrorCode unauthorizedErrorCode = DRunErrorCode.unauthorized,
  }) {
    final statusCode = response?.statusCode;
    final serverMessage = _extractServerMessage(response?.data);
    final message = [
      if (statusCode != null) 'HTTP $statusCode',
      if (serverMessage != null) serverMessage,
      if (statusCode == null && serverMessage == null) 'HTTP request failed',
    ].join(': ');
    final errorCode = switch (statusCode) {
      400 => DRunErrorCode.badRequest,
      401 => unauthorizedErrorCode,
      403 => DRunErrorCode.forbidden,
      404 => DRunErrorCode.notFound,
      406 || 409 => DRunErrorCode.invalidData,
      422 => DRunErrorCode.validationError,
      final int code when code >= 500 => DRunErrorCode.serverError,
      _ => DRunErrorCode.badResponse,
    };

    return NetworkHttpError._(
      message,
      url: response?.requestOptions.path,
      serverMessage: serverMessage,
      httpErrorCode: statusCode,
      errorCode: errorCode,
      stackTrace: stackTrace,
      cause: cause,
    );
  }

  factory NetworkHttpError.fromDioException(
    DioException error, {
    StackTrace? stackTrace,
    DRunErrorCode unauthorizedErrorCode = DRunErrorCode.unauthorized,
  }) {
    if (error.response != null) {
      return NetworkHttpError.error(
        error.response,
        stackTrace: stackTrace,
        cause: error,
        unauthorizedErrorCode: unauthorizedErrorCode,
      );
    }

    final (errorCode, shouldShowMessage) = switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        (DRunErrorCode.networkTimeout, true),
      DioExceptionType.connectionError => (
          DRunErrorCode.networkConnectionFailed,
          true
        ),
      DioExceptionType.badCertificate => (DRunErrorCode.badCertificate, true),
      DioExceptionType.cancel => (DRunErrorCode.unexpected, false),
      DioExceptionType.badResponse => (DRunErrorCode.badResponse, true),
      DioExceptionType.unknown => (DRunErrorCode.unexpected, true),
    };

    return NetworkHttpError._(
      error.message ?? error.type.name,
      url: error.requestOptions.path,
      shouldShowMessage: shouldShowMessage,
      errorCode: errorCode,
      stackTrace: stackTrace,
      cause: error,
    );
  }

  final String? serverMessage;

  static String? _extractServerMessage(dynamic data) {
    String? candidate;
    if (data is String) {
      candidate = data;
    } else if (data is Map) {
      for (final key in const ['detail', 'message', 'title']) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) {
          candidate = value;
          break;
        }
      }
      candidate ??= _extractServerMessage(data['error']);
    }

    final trimmed = candidate?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed.length > 300 ? trimmed.substring(0, 300) : trimmed;
  }
}
