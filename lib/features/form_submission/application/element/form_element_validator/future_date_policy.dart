import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Date and date-time fields refuse a date after today, unless the form field
/// allows it with `"allowFutureDates": true` in its properties, as an expiry
/// date needs.
///
/// "Today" is the phone's local day; the sync screen warns when the phone
/// clock differs from the server's.
abstract final class FutureDatePolicy {
  static const property = 'allowFutureDates';
  static const errorKey = 'futureDate';

  static bool appliesTo(FieldTemplate template) {
    if (template.type != ValueType.Date &&
        template.type != ValueType.DateTime) {
      return false;
    }
    final allowed = template.properties[property];
    return allowed != true && allowed != 'true';
  }

  /// The last moment of today on the phone.
  static DateTime endOfToday([DateTime? now]) {
    final today = now ?? DateTime.now();
    return DateTime(today.year, today.month, today.day, 23, 59, 59, 999);
  }

  /// Whether a stored value (an ISO-8601 string) falls on a later day.
  static bool isAfterToday(Object? value, [DateTime? now]) {
    final date = value is String ? DateTime.tryParse(value) : null;
    return date != null && date.toLocal().isAfter(endOfToday(now));
  }
}

/// Fails with [FutureDatePolicy.errorKey] when the value is after today.
class NoFutureDateValidator extends Validator<dynamic> {
  const NoFutureDateValidator();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) =>
      FutureDatePolicy.isAfterToday(control.value)
          ? const <String, dynamic>{FutureDatePolicy.errorKey: true}
          : null;
}
