import 'package:d_sdk/core/exception/exception.dart';

class NetworkException extends DError {
  NetworkException(
    String message, {
    DErrorComponent? errorComponent = DErrorComponent.Server,
    super.url,
    super.cause,
    required super.errorCode,
    super.httpErrorCode,
    super.stackTrace,
    super.shouldShowMessage = true,
  }) : super(message: message, errorComponent: errorComponent);
}

class InternalServerError extends NetworkException {
  InternalServerError(
      {int? httpErrorCode,
      String? url,
      String? message,
      Exception? cause,
      StackTrace? stackTrace})
      : super(message ?? "Internal Server Error.",
            url: url,
            errorCode: DRunErrorCode.apiError,
            httpErrorCode: httpErrorCode,
            cause: cause,
            stackTrace: stackTrace);
}
