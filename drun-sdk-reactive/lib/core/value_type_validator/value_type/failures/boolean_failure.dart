import 'package:d_sdk/core/exception/exception.dart';

/// Failure types for Boolean validation
sealed class BooleanFailure extends DException {
  const BooleanFailure();
}

final class OneIsNotTrueException extends BooleanFailure {
  const OneIsNotTrueException();

  @override
  String toString() => 'One is not considered true.';
}

final class ZeroIsNotFalseException extends BooleanFailure {
  const ZeroIsNotFalseException();

  @override
  String toString() => 'Zero is not considered false.';
}

final class BooleanMalformedException extends BooleanFailure {
  const BooleanMalformedException();

  @override
  String toString() => 'The boolean value is malformed.';
}
