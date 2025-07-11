import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/database/shared/value_type.dart';

abstract class ValidationService {
  DException? checkFieldError(
    ValueType? valueType,
    String? fieldValue,
    String? fieldMask,
    bool allowFutureDates,
  );
}

class ValidationMessage {
  ValidationMessage({required this.messageType, required this.message});

  final ValidationMessageType messageType;
  final Map<String, String> message;
}

enum ValidationMessageType {
  error,
  hint,
  information,
}

// /// Synchronously validate local rules (e.g., min/max, regex).
// ValidationResult validateSync(
//   FieldTemplate element,
//   dynamic newValue,
//   Map<String, dynamic> allValues,
// );
//
// /// Asynchronously validate rules that require remote lookups
// /// (e.g. uniqueness checks against a code list API).
// Future<ValidationResult> validateAsync(
//   FieldTemplate element,
//   dynamic newValue,
//   Map<String, dynamic> allValues,
// );
