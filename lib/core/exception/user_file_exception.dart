import 'package:datarunmobile/core/exception/d_error.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';

class UserFileException extends DError {
  UserFileException(
    String message, {
    super.url,
    super.cause,
    super.errorCode = DRunErrorCode.systemFileError,
    super.httpErrorCode,
    super.stackTrace,
  }) : super(message: message, errorComponent: DErrorComponent.SDK);

  @override
  String toString() => 'UserFileException: $message' +
      (cause != null ? '\n  Original error: $cause' : '') +
      (stackTrace != null ? '\n  StackTrace: \n$stackTrace' : '');
}
