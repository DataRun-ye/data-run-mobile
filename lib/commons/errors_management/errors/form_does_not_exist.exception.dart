import 'package:datarunmobile/core/exception/d_exception.dart';

class FormDoesNotExistException extends DException {
  FormDoesNotExistException([Object? cause])
      : super('FormDoesNotExistException', cause);
}
