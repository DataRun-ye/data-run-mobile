import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/form/rule/choice_filter.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/q_reactive_multi_select_field.widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  test('required multi-choice blocks saving a new repeat row until selected',
      () {
    final row = _buildRepeatRow();
    final choices = row.control('choices') as FormControl<List<String>>;

    expect(row.invalid, isTrue);
    expect(choices.hasError(ValidationMessage.required), isTrue);

    choices.updateValue(['choice-a']);

    expect(row.valid, isTrue);
  });

  test('required multi-choice blocks saving an edited repeat row after clear',
      () {
    final row = _buildRepeatRow(
      initialValue: {
        'choices': ['choice-a'],
      },
    );
    final choices = row.control('choices') as FormControl<List<String>>;

    expect(row.valid, isTrue);

    choices.updateValue([]);

    expect(row.invalid, isTrue);
    expect(choices.hasError(ValidationMessage.required), isTrue);
  });

  test('choice filtering preserves selected option codes', () {
    final optionA = _option(code: 'choice-a', name: 'Choice A');
    final optionB = _option(code: 'choice-b', name: 'Choice B');
    final control = FormControl<List<String>>(value: ['choice-a']);
    final field = FieldInstance<List<String>>(
      form: FormGroup({'choices': control}),
      template: FieldTemplate(
        id: 'choices-id',
        name: 'choices',
        type: ValueType.SelectMulti,
      ),
      choiceFilter: ChoiceFilter(
        expression: "code == 'choice-a'",
        options: [optionA, optionB],
      ),
      elementProperties: FieldElementState<List<String>>(
        visibleOptions: [optionA, optionB],
      ),
    );

    field.evaluate(emitEvent: false);

    expect(field.visibleOption, [optionA]);
    expect(field.value, ['choice-a']);
  });

  test('choice filters react when their source control changes', () {
    final optionA = _option(code: 'choice-a', name: 'Choice A');
    final optionB = _option(code: 'choice-b', name: 'Choice B');
    final sourceControl = FormControl<String>(value: 'choice-a');
    final choicesControl = FormControl<List<String>>(value: ['choice-a']);
    final form = FormGroup({
      'source': sourceControl,
      'choices': choicesControl,
    });
    final source = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'source-id',
        name: 'source',
        type: ValueType.SelectOne,
      ),
      elementProperties: FieldElementState<String>(),
    );
    final choices = FieldInstance<List<String>>(
      form: form,
      template: FieldTemplate(
        id: 'choices-id',
        name: 'choices',
        type: ValueType.SelectMulti,
      ),
      choiceFilter: ChoiceFilter(
        expression: '#{source} == code',
        options: [optionA, optionB],
      ),
      elementProperties: FieldElementState<List<String>>(
        visibleOptions: [optionA, optionB],
      ),
    );
    final root = Section(
      form: form,
      template: SectionTemplate(id: 'root-id', path: ''),
      elements: {
        'source': source,
        'choices': choices,
      },
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);

    expect(choices.visibleOption, [optionA]);
    expect(choices.value, ['choice-a']);

    sourceControl.updateValue('choice-b', emitEvent: false);
    source.handleControlValueChanged('choice-b');

    expect(choices.visibleOption, [optionB]);
    expect(choices.value, isEmpty);
    root.dispose();
  });

  test('choice filters do not trim selections while the field is hidden', () {
    final optionA = _option(code: 'choice-a', name: 'Choice A');
    final optionB = _option(code: 'choice-b', name: 'Choice B');
    final sourceControl = FormControl<String>(value: 'choice-a');
    final choicesControl = FormControl<List<String>>(value: ['choice-a']);
    final form = FormGroup({
      'source': sourceControl,
      'choices': choicesControl,
    });
    final source = FieldInstance<String>(
      form: form,
      template: FieldTemplate(
        id: 'source-id',
        name: 'source',
        type: ValueType.SelectOne,
      ),
      elementProperties: FieldElementState<String>(),
    );
    final choices = FieldInstance<List<String>>(
      form: form,
      template: FieldTemplate(
        id: 'choices-id',
        name: 'choices',
        type: ValueType.SelectMulti,
      ),
      choiceFilter: ChoiceFilter(
        expression: '#{source} == code',
        options: [optionA, optionB],
      ),
      elementProperties: FieldElementState<List<String>>(
        visibleOptions: [optionA, optionB],
      ),
    );
    final root = Section(
      form: form,
      template: SectionTemplate(id: 'root-id', path: ''),
      elements: {
        'source': source,
        'choices': choices,
      },
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);

    choices.markAsHidden(emitEvent: false);
    source.updateValue('choice-b', emitEvent: false);

    expect(choices.hidden, isTrue);
    expect(choices.visibleOption, [optionB]);
    expect(choices.value, ['choice-a']);

    source.updateValue('choice-a', emitEvent: false);
    choices.restoreVisibilityAfterParentShown(emitEvent: false);

    expect(choices.visible, isTrue);
    expect(choices.visibleOption, [optionA]);
    expect(choices.value, ['choice-a']);

    choices.markAsHidden(emitEvent: false);
    source.updateValue('choice-b', emitEvent: false);
    choices.restoreVisibilityAfterParentShown(emitEvent: false);

    expect(choices.visible, isTrue);
    expect(choices.visibleOption, [optionB]);
    expect(choices.value, isEmpty);
    root.dispose();
  });

  test('options without an option filter remain visible', () {
    final filteredOption = _option(
      code: 'filtered',
      name: 'Filtered',
      filterExpression: "#{source} == 'yes'",
    );
    final unfilteredOption = _option(code: 'unfiltered', name: 'Unfiltered');
    final filter = ChoiceFilter(
      expression: null,
      options: [filteredOption, unfilteredOption],
    );

    expect(filter.dependencies, ['source']);
    expect(filter.evaluate({'source': 'no'}), [unfilteredOption]);
    expect(
      filter.evaluate({'source': 'yes'}),
      [filteredOption, unfilteredOption],
    );
  });

  test('same-named repeat fields filter within their own row', () {
    final optionA = _option(code: 'choice-a', name: 'Choice A');
    final optionB = _option(code: 'choice-b', name: 'Choice B');
    final repeatTemplate = SectionTemplate(
      id: 'items-id',
      path: 'items',
      name: 'items',
      repeatable: true,
    );
    final sourceTemplate = FieldTemplate(
      id: 'source-id',
      parent: repeatTemplate.id,
      path: 'items.source',
      name: 'source',
      type: ValueType.SelectOne,
    );
    final choicesTemplate = FieldTemplate(
      id: 'choices-id',
      parent: repeatTemplate.id,
      path: 'items.choices',
      name: 'choices',
      type: ValueType.SelectMulti,
    );
    final form = FormGroup({
      'items': FormArray<Map<String, Object?>>([
        FormGroup({
          'source': FormControl<String>(value: 'choice-a'),
          'choices': FormControl<List<String>>(value: ['choice-a']),
        }),
        FormGroup({
          'source': FormControl<String>(value: 'choice-b'),
          'choices': FormControl<List<String>>(value: ['choice-b']),
        }),
      ]),
    });
    final firstRow = _repeatChoiceRow(
      form: form,
      repeatTemplate: repeatTemplate,
      sourceTemplate: sourceTemplate,
      choicesTemplate: choicesTemplate,
      options: [optionA, optionB],
    );
    final secondRow = _repeatChoiceRow(
      form: form,
      repeatTemplate: repeatTemplate,
      sourceTemplate: sourceTemplate,
      choicesTemplate: choicesTemplate,
      options: [optionA, optionB],
    );
    final repeat = RepeatSection(
      template: repeatTemplate,
      form: form,
      elements: [firstRow, secondRow],
    );
    final root = Section(
      form: form,
      template: SectionTemplate(id: 'root-id', path: ''),
      elements: {'items': repeat},
    )
      ..bindControlReferences()
      ..resolveDependencies()
      ..evaluate(emitEvent: false);
    final firstChoices =
        firstRow.element('choices') as FieldInstance<List<String>>;
    final secondChoices =
        secondRow.element('choices') as FieldInstance<List<String>>;

    expect(firstChoices.visibleOption, [optionA]);
    expect(secondChoices.visibleOption, [optionB]);

    final firstSource = firstRow.element('source') as FieldInstance<String>;
    firstSource.elementControl.updateValue('choice-b', emitEvent: false);
    firstSource.handleControlValueChanged('choice-b');

    expect(firstChoices.visibleOption, [optionB]);
    expect(secondChoices.visibleOption, [optionB]);
    expect(secondChoices.value, ['choice-b']);
    root.dispose();
  });

  test('legacy names and translated labels reopen as canonical option codes',
      () {
    final optionA = _option(
      code: 'choice-a',
      name: 'Choice A',
      label: const {'ar': 'الخيار أ'},
    );
    final optionB = _option(code: 'choice-b', name: 'Choice B');
    final accessor = FormOptionMultiSelectionValueAccessor();

    final selected = accessor.modelToViewValue(
      [optionA, optionB],
      ['الخيار أ', 'Choice B'],
    );

    expect(selected, [optionA, optionB]);
    expect(
      accessor.viewToModelValue([optionA, optionB], selected),
      ['choice-a', 'choice-b'],
    );
  });
}

RepeatItemInstance _repeatChoiceRow({
  required FormGroup form,
  required SectionTemplate repeatTemplate,
  required FieldTemplate sourceTemplate,
  required FieldTemplate choicesTemplate,
  required List<FormOption> options,
}) {
  return RepeatItemInstance(
    template: repeatTemplate,
    form: form,
    elements: {
      'source': FieldInstance<String>(
        form: form,
        template: sourceTemplate,
        elementProperties: FieldElementState<String>(),
      ),
      'choices': FieldInstance<List<String>>(
        form: form,
        template: choicesTemplate,
        choiceFilter: ChoiceFilter(
          expression: '#{source} == code',
          options: options,
        ),
        elementProperties: FieldElementState<List<String>>(
          visibleOptions: options,
        ),
      ),
    },
  );
}

FormOption _option({
  required String code,
  required String name,
  Map<String, dynamic> label = const {},
  String? filterExpression,
}) {
  return FormOption(
    id: '$code-id',
    optionSet: 'options',
    code: code,
    name: name,
    label: label,
    order: 0,
    filterExpression: filterExpression,
  );
}

FormGroup _buildRepeatRow({Map<String, Object?>? initialValue}) {
  final repository = FormTemplateRepository.inMemory(
    formTemplateModel: FormTemplateModel(
      id: 'form-id',
      name: 'form',
      versionUid: 'version-id',
      versionNumber: 1,
      fields: BuiltList<Template>(),
      sections: BuiltList<Template>(),
      options: BuiltList<FormOption>(),
    ),
  );
  final repeat = SectionTemplate(
    id: 'repeat-id',
    path: 'items',
    name: 'items',
    repeatable: true,
    children: [
      FieldTemplate(
        id: 'choices-id',
        parent: 'repeat-id',
        path: 'items.choices',
        name: 'choices',
        type: ValueType.SelectMulti,
        mandatory: true,
      ),
    ],
  );

  return FormElementControlBuilder.createSectionFormGroup(
    repository,
    repeat,
    initialValue: initialValue,
  );
}
