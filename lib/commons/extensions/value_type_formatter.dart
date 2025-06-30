import 'package:d2_remote/modules/datarun/common/standard_extensions.dart';
import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';

extension ValueTypeFormatter on String? {
  String? formatData(ValueType? valueType) {
    if (valueType?.isInteger == true) return _formatInteger(this!);
    if (valueType?.isDecimal == true) return _formatDecimal(this!);
    if (valueType?.isBoolean == true) return _formatBoolean(this!);
    return this;
  }

  String? _formatInteger(String value) {
    return double.tryParse(value)?.let((v) => v.toInt()).toString();
  }

  String? _formatDecimal(String value) {
    return double.tryParse(value)?.toString();
  }

  String? _formatBoolean(String value) {
    return switch (value) {
      '1' => true,
      '0' => false,
      _ => value.toBooleanStrictOrNull()
    }
        ?.toString();
  }

  bool? toBooleanStrictOrNull() => switch (this) {
        'true' => true,
        'false' => false,
        _ => null,
      };
}
