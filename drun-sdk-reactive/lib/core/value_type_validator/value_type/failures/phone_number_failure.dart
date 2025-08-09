import 'package:d_sdk/core/exception/exception.dart';

/// PhoneNumber Failure
sealed class PhoneNumberFailure extends DException {
  const PhoneNumberFailure();
}

final class MalformedPhoneNumberException extends PhoneNumberFailure {
  const MalformedPhoneNumberException();

  @override
  String toString() => 'Phone number is malformed.';
}
