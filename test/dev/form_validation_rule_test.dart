import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/rule/action.dart';
import 'package:datarunmobile/core/form/rule/rule.dart';
import 'package:datarunmobile/core/form/rule/rule_action.dart';
import 'package:datarunmobile/core/form/rule/validation_rule.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  test('live malaria age uses validationRule instead of its stale Error copy',
      () async {
    final repository = formRepositoryFromJson(await readJsonMap(
      'test/fixtures/live_forms/KcsA3KETRbY-v24.json',
    ));
    final form = FormGroup(
      FormElementControlBuilder.formDataControls(repository, const {}),
    );
    final root = Section(
      template: repository.rootSection,
      form: form,
      elements: FormElementBuilder.buildFormElements(form, repository),
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);
    final main = root.element('mcase') as Section;
    final age = main.element('age') as FieldInstance<String>;
    final message = age.template.validationRule!.displayMessage;

    age.updateValue('1900-01-01', emitEvent: false);

    expect(age.elementControl.hasError(message), isTrue);

    age.updateValue('2000-01-01', emitEvent: false);

    expect(age.elementControl.hasError(message), isFalse);
    root.dispose();
  });

  test('validationRule suppresses the compatibility Error action', () {
    const validationMessage = 'validation-rule';
    const compatibilityMessage = 'compatibility-error';
    final control = FormControl<int>();
    final form = FormGroup({'target': control});
    final target = FieldInstance<int>(
      form: form,
      template: FieldTemplate(
        id: 'target-id',
        name: 'target',
        type: ValueType.Integer,
        validationRule: ValidationRule(
          field: 'target',
          expression: '#{target} > 100',
          validationMessage: const IMapConst({
            'en': validationMessage,
            'ar': validationMessage,
          }),
        ),
        rules: [
          _errorRule(
            field: 'target',
            expression: '#{target} > 10',
            message: compatibilityMessage,
          ),
        ],
      ),
      elementProperties: FieldElementState<int>(),
    );
    final root = Section(
      template: SectionTemplate(id: 'root-id', path: ''),
      form: form,
      elements: {'target': target},
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);

    target.updateValue(50, emitEvent: false);

    expect(control.hasError(validationMessage), isFalse);
    expect(control.hasError(compatibilityMessage), isFalse);
    expect(control.valid, isTrue);

    target.updateValue(150, emitEvent: false);

    expect(control.hasError(validationMessage), isTrue);
    expect(control.hasError(compatibilityMessage), isFalse);
    root.dispose();
  });

  test('validationRule dependencies react without a compatibility Error rule',
      () {
    const validationMessage = 'dependent-validation';
    final sourceControl = FormControl<String>(value: 'valid');
    final targetControl = FormControl<String>(
      validators: const [RequiredFieldValidator()],
    );
    final form = FormGroup({
      'source': sourceControl,
      'target': targetControl,
    });
    final source = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'source-id',
        name: 'source',
        type: ValueType.Text,
      ),
      elementProperties: FieldElementState<String>(),
    );
    final target = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'target-id',
        name: 'target',
        type: ValueType.Text,
        mandatory: true,
        validationRule: ValidationRule(
          field: 'target',
          expression: "#{source} == 'invalid'",
          validationMessage: const IMapConst({
            'en': validationMessage,
            'ar': validationMessage,
          }),
        ),
      ),
      elementProperties: FieldElementState<String>(mandatory: true),
    );
    final root = Section(
      template: SectionTemplate(id: 'root-id', path: ''),
      form: form,
      elements: {'source': source, 'target': target},
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);

    source.updateValue('invalid', emitEvent: false);

    expect(targetControl.hasError(validationMessage), isTrue);
    expect(targetControl.hasError(ValidationMessage.required), isTrue);

    source.updateValue('valid', emitEvent: false);

    expect(targetControl.hasError(validationMessage), isFalse);
    expect(targetControl.hasError(ValidationMessage.required), isTrue);
    root.dispose();
  });

  test('validationRule is restored when its parent section becomes visible',
      () {
    const validationMessage = 'restored-validation';
    final toggleControl = FormControl<String>(value: 'no');
    final sourceControl = FormControl<String>(value: 'invalid');
    final targetControl = FormControl<String>();
    final form = FormGroup({
      'toggle': toggleControl,
      'source': sourceControl,
      'container': FormGroup({'target': targetControl}),
    });
    final toggle = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'toggle-id',
        name: 'toggle',
        type: ValueType.Text,
      ),
      elementProperties: FieldElementState<String>(),
    );
    final source = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'source-id',
        name: 'source',
        type: ValueType.Text,
      ),
      elementProperties: FieldElementState<String>(),
    );
    final target = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'target-id',
        name: 'target',
        type: ValueType.Text,
        validationRule: ValidationRule(
          field: 'target',
          expression: "#{source} == 'invalid'",
          validationMessage: const IMapConst({
            'en': validationMessage,
            'ar': validationMessage,
          }),
        ),
      ),
      elementProperties: FieldElementState<String>(),
    );
    final container = Section(
      form: form,
      template: SectionTemplate(
        id: 'container-id',
        name: 'container',
        path: 'container',
        rules: [
          _showRule(
            field: 'container',
            expression: "#{toggle} == 'yes'",
          ),
        ],
      ),
      elements: {'target': target},
    );
    final root = Section(
      template: SectionTemplate(id: 'root-id', path: ''),
      form: form,
      elements: {
        'toggle': toggle,
        'source': source,
        'container': container,
      },
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);

    expect(container.hidden, isTrue);
    expect(target.hidden, isTrue);
    expect(targetControl.hasError(validationMessage), isFalse);

    toggle.updateValue('yes', emitEvent: false);

    expect(container.visible, isTrue);
    expect(target.visible, isTrue);
    expect(targetControl.hasError(validationMessage), isTrue);
    root.dispose();
  });
}

Rule _errorRule({
  required String field,
  required String expression,
  required String message,
}) {
  final action = RuleAction(
    action: RuleActionType.Error,
    expression: expression,
    message: IMapConst({'en': message, 'ar': message}),
  );
  return Rule(
    field: field,
    expression: expression,
    action: RuleActionType.Error,
    ruleAction: action,
  );
}

Rule _showRule({
  required String field,
  required String expression,
}) {
  final action = RuleAction(
    action: RuleActionType.Show,
    expression: expression,
  );
  return Rule(
    field: field,
    expression: expression,
    action: RuleActionType.Show,
    ruleAction: action,
  );
}
