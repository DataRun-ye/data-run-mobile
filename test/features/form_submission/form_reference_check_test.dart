import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/rule/rule.dart';
import 'package:datarunmobile/core/form/rule/validation_rule.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/form_reference_check.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FormTemplateModel form({
    required List<FieldTemplate> fields,
    List<SectionTemplate> sections = const [],
    List<FormOption> options = const [],
  }) =>
      FormTemplateModel(
        id: 'form-1',
        name: 'Form',
        versionUid: 'version-1',
        versionNumber: 1,
        fields: BuiltList(fields),
        sections: BuiltList(sections),
        options: BuiltList(options),
      );

  Rule showWhen(String expression) => Rule.fromJson({
        'field': 'target',
        'action': 'Show',
        'expression': expression,
      });

  test('accepts a form whose expressions name its own fields', () {
    final template = form(
      sections: [SectionTemplate(id: 'main', name: 'main', path: 'main')],
      fields: [
        FieldTemplate(
            id: 'status',
            name: 'status',
            path: 'main.status',
            type: ValueType.Text),
        FieldTemplate(
          id: 'served',
          name: 'served',
          path: 'main.served',
          type: ValueType.Integer,
          rules: [showWhen("#{status} == 'done'")],
          validationRule: ValidationRule(
            field: 'served',
            expression: '#{served} > 10',
          ),
        ),
      ],
    );

    expect(FormReferenceCheck.unknownReferences(template), isEmpty);
  });

  test('reports misspelled names in checks, conditions and filters', () {
    final template = form(
      fields: [
        FieldTemplate(
            id: 'nets', name: 'nets', path: 'nets', type: ValueType.Integer),
        FieldTemplate(
          id: 'members',
          name: 'members',
          path: 'members',
          type: ValueType.Integer,
          rules: [showWhen('#{Nets} > 0')],
          validationRule: ValidationRule(
            field: 'members',
            expression: '#{members} < #{netCount}',
          ),
        ),
        FieldTemplate(
          id: 'kind',
          name: 'kind',
          path: 'kind',
          type: ValueType.SelectOne,
          listName: 'kinds',
          choiceFilter: '#{regionCode} == 1',
        ),
      ],
      options: [
        FormOption(
          id: 'kind-a',
          optionSet: 'kinds-set',
          code: 'a',
          name: 'a',
          label: const {},
          order: 1,
          listName: 'kinds',
          filterExpression: '#{district} == 2',
        ),
      ],
    );

    expect(FormReferenceCheck.unknownReferences(template), {
      'members': {'Nets', 'netCount'},
      'kind': {'regionCode'},
      'kinds': {'district'},
    });
  });
}
