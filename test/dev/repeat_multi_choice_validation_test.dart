import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/data/form_template_repository.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
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
    final state = FieldElementState<List<String>>(
      value: ['choice-a'],
      visibleOptions: [optionA, optionB],
    );

    final filtered =
        state.resetValueFromVisibleOptions(visibleOptions: [optionA]);

    expect(filtered.value, ['choice-a']);
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

FormOption _option({
  required String code,
  required String name,
  Map<String, dynamic> label = const {},
}) {
  return FormOption(
    id: '$code-id',
    optionSet: 'options',
    code: code,
    name: name,
    label: label,
    order: 0,
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
