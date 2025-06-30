import 'package:d2_remote/core/datarun/exception/d_exception.dart';
import 'package:d2_remote/modules/datarun/form/shared/field_template/field_template.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';

abstract class ValidationService {
  DException? checkFieldError(
    ValueType? valueType,
    String? fieldValue,
    String? fieldMask,
    bool allowFutureDates,
  );

  /// Synchronously validate local rules (e.g., min/max, regex).
  ValidationResult validateSync(
    FieldTemplate element,
    dynamic newValue,
    Map<String, dynamic> allValues,
  );

  /// Asynchronously validate rules that require remote lookups
  /// (e.g. uniqueness checks against a code list API).
  Future<ValidationResult> validateAsync(
    FieldTemplate element,
    dynamic newValue,
    Map<String, dynamic> allValues,
  );
}
