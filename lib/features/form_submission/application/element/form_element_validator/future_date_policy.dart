import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
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

  static bool appliesTo(FieldTemplate template) =>
      _isDate(template) && !_allows(template);

  /// The fields of a form version as this rule sees them: a date field also
  /// accepts future dates when the newest version of its form on the phone
  /// accepts them for the same field (same id, otherwise same name). A draft
  /// started before such a field was allowed future dates, like an expiry
  /// date flagged later, then accepts what a new form accepts.
  static List<Template> followingNewestVersion(
    List<Template> fields,
    List<Template> newestFields,
  ) {
    final allowedIds = <String>{};
    final allowedNames = <String>{};
    for (final field in newestFields.whereType<FieldTemplate>()) {
      if (_isDate(field) && _allows(field)) {
        allowedIds.add(field.id);
        if (field.name != null) allowedNames.add(field.name!);
      }
    }
    if (allowedIds.isEmpty) return fields;
    return [
      for (final field in fields)
        if (field is FieldTemplate &&
            appliesTo(field) &&
            (allowedIds.contains(field.id) ||
                allowedNames.contains(field.name)))
          _allowingFutureDates(field)
        else
          field,
    ];
  }

  static bool _isDate(FieldTemplate template) =>
      template.type == ValueType.Date || template.type == ValueType.DateTime;

  static bool _allows(FieldTemplate template) {
    final allowed = template.properties[property];
    return allowed == true || allowed == 'true';
  }

  static Template _allowingFutureDates(FieldTemplate field) {
    final json = Template.toJsonFactory(field);
    json['properties'] = <String, dynamic>{
      ...?(json['properties'] as Map?)?.cast<String, dynamic>(),
      property: true,
    };
    return Template.fromJsonFactory(json);
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
