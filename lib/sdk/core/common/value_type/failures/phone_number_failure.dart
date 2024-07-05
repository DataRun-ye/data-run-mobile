import 'package:freezed_annotation/freezed_annotation.dart';

import '../../exception/validation_exception.dart';

part 'phone_number_failure.freezed.dart';

@freezed
class PhoneNumberFailure
    with _$PhoneNumberFailure
    implements ValidationException {
  @Implements<ValidationException>()
  const factory PhoneNumberFailure.malformedPhoneNumberException(
      [@Default('ValidationException') String message]) = MalformedPhoneNumberException;
}
