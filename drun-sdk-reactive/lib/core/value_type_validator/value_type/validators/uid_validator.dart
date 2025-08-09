import 'package:d_sdk/core/value_type_validator/value_type/failures/uid_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class UidValidator extends ValueTypeValidator<UidFailure> {
  const UidValidator();

  static final RegExp UID_PATTERN = RegExp(r'^[a-zA-Z0-9]{11}$');

  static const int NUMBER_OF_UID_CHARS = 11;

  @override
  Result<String, UidFailure> validate(String value) {
    if (UID_PATTERN.hasMatch(value)) {
      return Result.success(value);
    } else if (value.length < NUMBER_OF_UID_CHARS) {
      return const Error(LessThanElevenCharsException());
    } else if (value.length > NUMBER_OF_UID_CHARS) {
      return const Error(MoreThanElevenCharsException());
    } else {
      return const Error(MalformedUidException());
    }
  }
}
