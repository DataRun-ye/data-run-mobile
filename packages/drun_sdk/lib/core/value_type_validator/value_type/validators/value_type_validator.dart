import 'package:d_sdk/core/exception/exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ValueTypeValidator<T extends DException> {
  const ValueTypeValidator();

  Result<String, T> validate(String value);
}
