import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/data_instance/application/reference_value_extractor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const extractor = ReferenceValueExtractor();
  late FormTemplateModel template;

  setUp(() {
    template = _template();
  });

  test('extracts ordinary, repeat, and nested repeat Reference values', () {
    final occurrences = extractor.extract(
      template: template,
      formData: {
        'topReference': 'a1234567890',
        'rows': [
          {
            'rowReference': 'b1234567890',
            'otherText': 'not-a-reference',
            'nested': [
              {'nestedReference': 'c1234567890'},
              {'nestedReference': null},
            ],
          },
          {
            'rowReference': null,
            'nested': [
              {'nestedReference': 'd1234567890'},
            ],
          },
        ],
      },
    );

    expect(
      occurrences,
      const [
        ReferenceValueOccurrence(
          elementPath: 'topReference',
          uid: 'a1234567890',
        ),
        ReferenceValueOccurrence(
          elementPath: 'rows.rowReference',
          uid: 'b1234567890',
        ),
        ReferenceValueOccurrence(
          elementPath: 'rows.nested.nestedReference',
          uid: 'c1234567890',
        ),
        ReferenceValueOccurrence(
          elementPath: 'rows.nested.nestedReference',
          uid: 'd1234567890',
        ),
      ],
    );
  });

  test('retains duplicate values for the caller to validate or deduplicate',
      () {
    final occurrences = extractor.extract(
      template: template,
      formData: {
        'rows': [
          {'rowReference': 'a1234567890'},
          {'rowReference': 'a1234567890'},
        ],
      },
    );

    expect(occurrences, hasLength(2));
    expect(
      occurrences.map((occurrence) => occurrence.uid),
      everyElement('a1234567890'),
    );
  });

  test('ignores missing, null, blank, and non-Reference values', () {
    final occurrences = extractor.extract(
      template: template,
      formData: {
        'topReference': ' ',
        'rows': [
          {'rowReference': null, 'otherText': 'a1234567890'},
          <String, dynamic>{},
        ],
      },
    );

    expect(occurrences, isEmpty);
  });

  test('rejects non-string Reference values', () {
    for (final value in <Object>[
      <String, Object?>{},
      42,
      ['a1234567890'],
    ]) {
      expect(
        () => extractor.extract(
          template: template,
          formData: {'topReference': value},
        ),
        throwsFormatException,
      );
    }
  });

  test('rejects malformed repeat and section containers', () {
    expect(
      () => extractor.extract(
        template: template,
        formData: {'rows': <String, Object?>{}},
      ),
      throwsFormatException,
    );
    expect(
      () => extractor.extract(
        template: template,
        formData: {
          'rows': [
            {'nested': 'not-a-section'},
          ],
        },
      ),
      throwsFormatException,
    );
  });
}

FormTemplateModel _template() {
  final topReference = FieldTemplate(
    id: 'top-reference',
    name: 'topReference',
    type: ValueType.Reference,
  );
  final rowReference = FieldTemplate(
    id: 'row-reference',
    name: 'rowReference',
    parent: 'rows',
    type: ValueType.Reference,
  );
  final otherText = FieldTemplate(
    id: 'other-text',
    name: 'otherText',
    parent: 'rows',
    type: ValueType.Text,
  );
  final nestedReference = FieldTemplate(
    id: 'nested-reference',
    name: 'nestedReference',
    parent: 'nested',
    type: ValueType.Reference,
  );
  final rows = SectionTemplate(
    id: 'rows',
    name: 'rows',
    path: 'rows',
    repeatable: true,
  );
  final nested = SectionTemplate(
    id: 'nested',
    name: 'nested',
    path: 'rows.nested',
    parent: 'rows',
    repeatable: true,
  );

  return FormTemplateModel(
    id: 'reference-form',
    name: 'Reference form',
    versionUid: 'reference-form-v1',
    versionNumber: 1,
    fields: BuiltList<Template>([
      topReference,
      rowReference,
      nestedReference,
      otherText,
    ]),
    sections: BuiltList<Template>([rows, nested]),
    options: BuiltList<FormOption>(),
  );
}
