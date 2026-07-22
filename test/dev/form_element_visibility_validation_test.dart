import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/rule/action.dart';
import 'package:datarunmobile/core/form/rule/rule.dart';
import 'package:datarunmobile/core/form/rule/rule_action.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
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

  test('required multi-choice is ignored while hidden and required again', () {
    final (:field, :control) = _buildMultiField(templateMandatory: true);

    expect(control.hasError(ValidationMessage.required), isTrue);

    field.markAsHidden(emitEvent: false);

    expect(field.form.valid, isTrue);

    field.markAsVisible(emitEvent: false);

    expect(control.hasError(ValidationMessage.required), isTrue);
    expect(field.form.invalid, isTrue);
  });

  test('rule-driven mandatory validation rejects empty multi-choice', () {
    final (:field, :control) = _buildMultiField(templateMandatory: false);

    expect(control.valid, isTrue);

    field.markAsMandatory(emitEvent: false);

    expect(control.hasError(ValidationMessage.required), isTrue);

    control.updateValue(['choice-a']);

    expect(control.valid, isTrue);
  });

  test('an element evaluates each rule expression once per pass', () {
    var evaluationCount = 0;
    final action = _CountingRuleAction(
      action: RuleActionType.Hide,
      expression: 'true',
      onEvaluate: () => evaluationCount++,
    );
    final field = _buildRuleField(action);

    field.evaluate(emitEvent: false);

    expect(evaluationCount, 1);
    expect(field.hidden, isTrue);
  });

  test('section restore and dependency updates use the same visibility rules',
      () {
    final form = FormGroup({
      'source': FormControl<String>(value: 'no'),
      'container': FormGroup({
        'target': FormControl<String>(),
      }),
    });
    final source = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'source-id',
        name: 'source',
        type: ValueType.Text,
      ),
      elementProperties: FieldElementState<String>(value: 'no'),
    );
    var targetEvaluationCount = 0;
    final targetAction = _CountingRuleAction(
      action: RuleActionType.Show,
      expression: "#{source} == 'yes'",
      onEvaluate: () => targetEvaluationCount++,
    );
    final target = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'target-id',
        name: 'target',
        type: ValueType.Text,
        rules: [_ruleFor('target', targetAction)],
      ),
      elementProperties: FieldElementState<String>(),
    );
    final container = Section(
      template: SectionTemplate(
        id: 'container-id',
        path: 'container',
        name: 'container',
      ),
      form: form,
      elements: {'target': target},
    );
    final root = Section(
      template: SectionTemplate(id: 'root-id', path: ''),
      form: form,
      elements: {
        'source': source,
        'container': container,
      },
    )..resolveDependencies();

    target.evaluate(emitEvent: false);
    expect(target.hidden, isTrue);

    container.markAsHidden(emitEvent: false);
    targetEvaluationCount = 0;
    container.markAsVisible(emitEvent: false);

    expect(targetEvaluationCount, 1);
    expect(target.hidden, isTrue);

    source.updateValue('yes', emitEvent: false);
    expect(target.visible, isTrue);

    container.markAsHidden(emitEvent: false);
    container.markAsVisible(emitEvent: false);
    expect(target.visible, isTrue);

    root.dispose();
  });

  test('real form restores required children whenever their section reappears',
      () async {
    final template = formTemplateFromJson(await readJsonMap(
      'example/Malaria Case Registration and Management Form.json',
    ));
    final repository = FormTemplateRepository.inMemory(
      formTemplateModel: template,
    );
    final form = FormGroup(
      FormElementControlBuilder.formDataControls(repository, const {}),
    );
    final root = Section(
      template: repository.rootSection,
      form: form,
      elements: FormElementBuilder.buildFormElements(form, repository),
    )
      ..resolveDependencies()
      ..evaluate(emitEvent: false);
    final mainSection = root.element('mcase') as Section;
    final performed =
        mainSection.element('is_test_preformed') as FieldInstance<String>;
    final testSection = root.element('testDetails') as Section;
    final testResult =
        testSection.element('testResult') as FieldInstance<String>;
    final testResultControl = testResult.elementControl;

    expect(testSection.hidden, isTrue);
    expect(testResult.hidden, isTrue);
    expect(testResultControl.disabled, isTrue);
    expect(testResultControl.hasError(ValidationMessage.required), isFalse);

    performed.updateValue('yes', emitEvent: false);

    expect(testSection.visible, isTrue);
    expect(testResult.visible, isTrue);
    expect(testResult.mandatory, isTrue);
    expect(testResultControl.disabled, isFalse);
    expect(testResultControl.hasError(ValidationMessage.required), isTrue);

    performed.updateValue('no', emitEvent: false);
    expect(testSection.hidden, isTrue);
    expect(testResultControl.hasError(ValidationMessage.required), isFalse);

    performed.updateValue('yes', emitEvent: false);
    expect(testResult.visible, isTrue);
    expect(testResult.mandatory, isTrue);
    expect(testResultControl.hasError(ValidationMessage.required), isTrue);

    root.dispose();
  });
}

FieldInstance<String> _buildRuleField(RuleAction action) {
  final form = FormGroup({'field': FormControl<String>()});
  return FieldInstance<String>(
    form: form,
    template: FieldTemplate(
      id: 'field-id',
      name: 'field',
      type: ValueType.Text,
      rules: [_ruleFor('field', action)],
    ),
    elementProperties: FieldElementState<String>(),
  );
}

Rule _ruleFor(String field, RuleAction action) => Rule(
      field: field,
      expression: action.expression,
      action: action.action,
      ruleAction: action,
    );

class _CountingRuleAction extends RuleAction {
  _CountingRuleAction({
    required super.action,
    required super.expression,
    required this.onEvaluate,
  });

  final void Function() onEvaluate;

  @override
  bool evaluate([Map<String, dynamic>? context]) {
    onEvaluate();
    return super.evaluate(context);
  }
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

({FieldInstance<List<String>> field, FormControl<List<String>> control})
    _buildMultiField({required bool templateMandatory}) {
  final control = FormControl<List<String>>(
    value: const [],
    validators: templateMandatory ? [const RequiredFieldValidator()] : const [],
  );
  final form = FormGroup({
    'field': control,
    'other': FormControl<String>(value: 'present'),
  });
  final template = FieldTemplate(
    id: 'field-id',
    name: 'field',
    type: ValueType.SelectMulti,
    mandatory: templateMandatory,
  );
  final field = FieldInstance<List<String>>(
    form: form,
    template: template,
    elementProperties: FieldElementState<List<String>>(
      mandatory: templateMandatory,
    ),
  );

  return (field: field, control: control);
}
