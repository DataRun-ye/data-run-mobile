import 'package:d_sdk/core/exception/d_exception.dart';

class FormDoesNotExistException extends DException {
  FormDoesNotExistException([Object? cause])
      : super('FormDoesNotExistException', cause);
}
