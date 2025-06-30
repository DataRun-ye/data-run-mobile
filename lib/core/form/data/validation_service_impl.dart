import 'package:d2_remote/core/datarun/exception/d_exception.dart';
import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:datarunmobile/core/form/data/validation_service.dart';
import 'package:multiple_result/multiple_result.dart';

class ValidationServiceImpl extends ValidationService {
  @override
  Future<dynamic> validateAsync(
      FieldTemplate element, newValue, Map<String, dynamic> allValues) {
    // TODO: implement validateAsync
    throw UnimplementedError();
  }

  @override
  validateSync(FieldTemplate element, newValue, Map<String, dynamic> allValues) {
    // TODO: implement validateSync
    throw UnimplementedError();
  }

  DException? checkFieldError(ValueType? valueType, String? fieldValue,
      String? fieldMask, bool allowFutureDates) {
    if (fieldValue.isNullOrEmpty) {
      return null;
    }

    return fieldValue.let((value) {
      final result = switch (valueType) {
        ValueType.Date =>
          _validateDateFormats(fieldValue, valueType, allowFutureDates),
        ValueType.Time => _validateTimeFormat(fieldValue, valueType),
        ValueType.DateTime =>
          _validateDateTimeFormat(fieldValue, valueType, allowFutureDates),
        ValueType.Age =>
          _validateDateFormats(fieldValue, valueType, allowFutureDates),
        _ => valueType?.validator.validate(value!)
      };
      return result?.whenError((error) => error);
    });
  }

  Result<String, DException> _validateDateFormats(
      String? fieldValue, ValueType? valueType, bool allowFutureDates) {}

  Result<String, DException> _validateTimeFormat(
      String? fieldValue, ValueType? valueType) {}

  Result<String, DException> _validateDateTimeFormat(
      String? fieldValue, ValueType? valueType, bool allowFutureDates) {}
}
