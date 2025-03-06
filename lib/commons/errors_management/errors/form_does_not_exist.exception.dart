import 'package:d2_remote/core/datarun/exception/exception.dart';

class FormDoesNotExistException extends DException {
  FormDoesNotExistException([Object? cause])
      : super('FormDoesNotExistException', cause);
}
