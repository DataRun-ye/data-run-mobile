import 'package:d_sdk/core/exception/exception.dart';

class DSyncException extends DError {
  DSyncException({
    String message = '',
    super.url,
    super.cause,
    super.errorCode = DRunErrorCode.syncError,
    super.httpErrorCode,
    super.stackTrace,
  }) : super(message: message, errorComponent: DErrorComponent.SDK);
}
