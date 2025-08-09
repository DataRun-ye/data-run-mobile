import 'package:d_sdk/core/exception/exception.dart';

class DDatabaseException extends DError {
  DDatabaseException(
    String message, {
    super.cause,
    required super.errorCode,
    super.stackTrace,
  }) : super(message: message, errorComponent: DErrorComponent.Database);
}

class NoActiveDatabaseInstance extends DDatabaseException {
  NoActiveDatabaseInstance({Exception? cause, StackTrace? stackTrace})
      : super("Failed to connect to the database, no Active user database.",
            cause: cause,
            stackTrace: stackTrace,
            errorCode: DRunErrorCode.noActiveDatabaseInstance);
}

class DDatabaseConnectionException extends DDatabaseException {
  DDatabaseConnectionException(
      {String? message, Exception? cause, StackTrace? stackTrace})
      : super("Failed to connect to the database ${message ?? ''}",
            cause: cause,
            stackTrace: stackTrace,
            errorCode: DRunErrorCode.databaseConnectionFailed);
}

class DatabaseInitException extends DDatabaseException {
  DatabaseInitException(
      {String? message, Exception? cause, StackTrace? stackTrace})
      : super("Failed to init user database ${message ?? ''}",
            cause: cause,
            stackTrace: stackTrace,
            errorCode: DRunErrorCode.databaseConnectionFailed);
}

class DRecordNotFoundException extends DDatabaseException {
  DRecordNotFoundException(
    String recordId, {
    Exception? cause,
    StackTrace? stackTrace,
  }) : super("record $recordId not found.",
            cause: cause,
            stackTrace: stackTrace,
            errorCode: DRunErrorCode.databaseQueryFailed);
}

class DDataIntegrityException extends DDatabaseException {
  DDataIntegrityException(
    String message, {
    Exception? cause,
    StackTrace? stackTrace,
  }) : super(message,
            cause: cause,
            stackTrace: stackTrace,
            errorCode: DRunErrorCode.databaseInternalError);
}
