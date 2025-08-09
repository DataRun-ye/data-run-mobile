import 'package:d_sdk/core/value_type_validator/value_type/failures/coordinate_failure.dart';
import 'package:d_sdk/core/value_type_validator/value_type/validators/value_type_validator.dart';
import 'package:multiple_result/multiple_result.dart';

class CoordinateValidator extends ValueTypeValidator<CoordinateFailure> {
  const CoordinateValidator();

  // static const String COORDINATE_PATTERN =
  //     r'^\\[[-+]?(180(\\.0+)?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d+)?),\\s*[-+]?([1-8]?\\d(\\.\\d+)?|90(\\.0+)?)]\$';

  static final coordinatePattern = RegExp(
      r'^\[[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?),\s*[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)\]$');

  @override
  Result<String, CoordinateFailure> validate(String value) {
    if (coordinatePattern.hasMatch(value)) {
      return Result.success(value);
    } else {
      return const Error(CoordinateMalformedException());
    }
  }
}
