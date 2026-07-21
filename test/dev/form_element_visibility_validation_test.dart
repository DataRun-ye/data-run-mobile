import 'package:d_sdk/core/form/element_template/field_template.entity.dart';
import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:datarunmobile/features/form_submission/application/element/rule_effect_state_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  setUpAll(() {
    if (!appLocator.isRegistered<RuleEffectStateFactory>()) {
      appLocator.registerFactory<RuleEffectStateFactory>(
        RuleEffectStateFactory.new,
      );
    }
  });

  test('template-required field is ignored while hidden and required again',
      () {
    final (:field, :control) = _buildField(templateMandatory: true);

    expect(control.hasError(ValidationMessage.required), isTrue);

    field.markAsHidden(emitEvent: false);

    expect(field.hidden, isTrue);
    expect(field.mandatory, isFalse);
    expect(control.disabled, isTrue);
    expect(field.form.valid, isTrue);

    field.markAsVisible(emitEvent: false);

    expect(field.visible, isTrue);
    expect(field.mandatory, isTrue);
    expect(control.disabled, isFalse);
    expect(control.hasError(ValidationMessage.required), isTrue);
  });

  test('rule-driven mandatory validation can be removed', () {
    final (:field, :control) = _buildField(templateMandatory: false);

    field.markAsMandatory(emitEvent: false);
    expect(control.hasError(ValidationMessage.required), isTrue);

    field.markAsUnMandatory(emitEvent: false);

    expect(field.mandatory, isFalse);
    expect(control.hasError(ValidationMessage.required), isFalse);
    expect(control.valid, isTrue);
  });

  test('temporary mandatory validation does not survive hide and show', () {
    final (:field, :control) = _buildField(templateMandatory: false);

    field.markAsMandatory(emitEvent: false);
    field.markAsHidden(emitEvent: false);
    field.markAsVisible(emitEvent: false);

    expect(field.visible, isTrue);
    expect(field.mandatory, isFalse);
    expect(control.hasError(ValidationMessage.required), isFalse);
    expect(control.valid, isTrue);
  });

  test('mandatory toggles preserve other validators without duplicates', () {
    final (:field, :control) = _buildField(templateMandatory: false);
    control.setValidators([Validators.email], autoValidate: true);
    control.updateValue('not-an-email');

    field.markAsMandatory(emitEvent: false);
    field.markAsMandatory(emitEvent: false);

    expect(
      control.validators.whereType<RequiredValidator>(),
      hasLength(1),
    );
    expect(control.hasError(ValidationMessage.email), isTrue);

    field.markAsUnMandatory(emitEvent: false);

    expect(control.validators.whereType<RequiredValidator>(), isEmpty);
    expect(control.hasError(ValidationMessage.email), isTrue);
  });
}

({FieldInstance<String> field, FormControl<String> control}) _buildField({
  required bool templateMandatory,
}) {
  final control = FormControl<String>(
    validators: templateMandatory ? [Validators.required] : [],
  );
  final form = FormGroup({
    'field': control,
    'other': FormControl<String>(value: 'present'),
  });
  final template = FieldTemplate(
    id: 'field-id',
    name: 'field',
    type: ValueType.Text,
    mandatory: templateMandatory,
  );
  final field = FieldInstance<String>(
    form: form,
    template: template,
    elementProperties: FieldElementState<String>(
      mandatory: templateMandatory,
    ),
  );

  return (field: field, control: control);
}
