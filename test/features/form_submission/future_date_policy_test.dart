import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/future_date_policy.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/reactive_date_time_picker/custom_reactive_date_picker.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  FieldTemplate field(ValueType type, [Map<String, dynamic>? properties]) =>
      FieldTemplate(
        id: 'field',
        name: 'field',
        type: type,
        properties: (properties ?? const {}).lock,
      );

  test('applies to date and date-time fields unless the field allows it', () {
    expect(FutureDatePolicy.appliesTo(field(ValueType.Date)), isTrue);
    expect(FutureDatePolicy.appliesTo(field(ValueType.DateTime)), isTrue);
    expect(FutureDatePolicy.appliesTo(field(ValueType.Time)), isFalse);
    expect(FutureDatePolicy.appliesTo(field(ValueType.Text)), isFalse);
    expect(
      FutureDatePolicy.appliesTo(
          field(ValueType.Date, {'allowFutureDates': true})),
      isFalse,
    );
    expect(
      FutureDatePolicy.appliesTo(
          field(ValueType.Date, {'allowFutureDates': 'true'})),
      isFalse,
    );
    expect(
      FutureDatePolicy.appliesTo(
          field(ValueType.Date, {'allowFutureDates': false})),
      isTrue,
    );
  });

  test('a later time today is not a future date, tomorrow is', () {
    final now = DateTime(2026, 11, 23, 9, 30);

    expect(FutureDatePolicy.isAfterToday('2026-11-23', now), isFalse);
    expect(FutureDatePolicy.isAfterToday('2026-11-23T22:00:00', now), isFalse);
    expect(FutureDatePolicy.isAfterToday('2026-11-22T08:00:00', now), isFalse);
    expect(FutureDatePolicy.isAfterToday('2026-11-24', now), isTrue);
    expect(FutureDatePolicy.isAfterToday(null, now), isFalse);
    expect(FutureDatePolicy.isAfterToday('not a date', now), isFalse);
  });

  test('date fields get the validator, expiry-style fields do not', () {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final value =
        DateTime(tomorrow.year, tomorrow.month, tomorrow.day).toIso8601String();

    final restricted = FormControl<String>(
      value: value,
      validators: FieldValidators.getValidators(field(ValueType.Date)),
    );
    final allowed = FormControl<String>(
      value: value,
      validators: FieldValidators.getValidators(
          field(ValueType.Date, {'allowFutureDates': true})),
    );

    expect(restricted.errors, {FutureDatePolicy.errorKey: true});
    expect(allowed.errors, isEmpty);
    expect(validationMessages()[FutureDatePolicy.errorKey], isNotNull);
  });

  test('the picker opens within its range', () {
    final first = DateTime(1900);
    final last = DateTime(2026, 11, 23, 23, 59, 59, 999);

    expect(
      CustomReactiveDateTimePicker.initialDateWithin(
          '2026-12-01T00:00:00', first, last),
      last,
    );
    expect(
      CustomReactiveDateTimePicker.initialDateWithin(
          '2026-11-01T10:00:00', first, last),
      DateTime(2026, 11, 1, 10),
    );
    expect(
      CustomReactiveDateTimePicker.initialDateWithin('1850-01-01', first, last),
      first,
    );
  });
}
