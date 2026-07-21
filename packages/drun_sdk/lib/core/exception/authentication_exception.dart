import 'package:d_sdk/core/exception/d_error.dart';
import 'package:d_sdk/core/exception/d_error_code.dart';

class AuthException extends DError {
  AuthException(
    String? message, {
    String? url,
    bool shouldShowMessage = true,
    super.httpErrorCode,
    DErrorComponent? errorComponent = DErrorComponent.SDK,
    super.cause,
    super.stackTrace,
    super.errorCode,
  }) : super(
            message: message,
            shouldShowMessage: shouldShowMessage,
            url: url,
            errorComponent: errorComponent);
}
