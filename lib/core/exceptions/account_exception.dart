import 'package:d_sdk/core/exception/exception.dart';

class AccountException extends DError {
  AccountException({String? message, Exception? cause, StackTrace? stackTrace})
      : super(
            message: "Failed to init user session ${message ?? ''}",
            cause: cause,
            stackTrace: stackTrace,
            errorComponent: DErrorComponent.SDK,
            errorCode: DRunErrorCode.noLoggedInUser);
}
