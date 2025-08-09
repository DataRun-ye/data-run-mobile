import 'package:d_sdk/core/value_type_validator/value_type/failures/email_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

/// EmailValidator: Validates email addresses using a regex.
class EmailValidator implements ValueTypeValidator<EmailFailure> {
  const EmailValidator();

  static final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Result<String, EmailFailure> validate(String value) {
    if (emailRegex.hasMatch(value)) {
      return Success(value);
    } else {
      return const Error(MalformedEmail());
    }
  }
}
