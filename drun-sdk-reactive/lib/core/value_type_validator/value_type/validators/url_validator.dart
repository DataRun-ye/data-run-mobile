import 'package:d_sdk/core/value_type_validator/value_type/failures/url_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class UrlValidator extends ValueTypeValidator<UrlFailure> {
  const UrlValidator();

  static const String URL_PATTERN =
      r'^(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$';

  @override
  Result<String, UrlFailure> validate(String value) {
    if (RegExp(URL_PATTERN).hasMatch(value)) {
      return Result.success(value);
    } else {
      return const Error(MalformedUrlException());
    }
  }
}
