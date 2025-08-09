import 'package:d_sdk/core/exception/d_error.dart';
import 'package:d_sdk/core/exception/d_error_code.dart';

class SessionExpiredException extends DError {
  SessionExpiredException(String? message)
      : super(
            errorCode: DRunErrorCode.sessionExpired,
            message: message ?? 'Expired User Session, login again');
}
