import 'package:d_sdk/core/exception/exception.dart';

class FormDoesNotExistException extends DException {
  FormDoesNotExistException([Object? cause])
      : super('FormDoesNotExistException', cause);
}
