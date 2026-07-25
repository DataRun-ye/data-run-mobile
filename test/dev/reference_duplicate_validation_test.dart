import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/data/reference_uid.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    await appLocator.reset();
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'reference-duplicate-test',
    );
    appLocator.registerSingleton<AppDatabase>(database);
  });

  tearDown(() async {
    await database.close();
    await appLocator.reset();
  });

  test('duplicate Reference UIDs invalidate dormant rows and release on delete',
      () {
    final fixture = _buildFixture();
    final rows = fixture.root.element('rows') as RepeatSection;
    final first =
        rows.elements.first.element('rowReference') as ReferenceFieldInstance;
    final second =
        rows.elements.last.element('rowReference') as ReferenceFieldInstance;

    expect(first.mountedControl, isNull);
    expect(second.mountedControl, isNull);
    expect(
      first.errors,
      contains(ReferenceValidationMessage.duplicate),
    );
    expect(
      second.errors,
      contains(ReferenceValidationMessage.duplicate),
    );
    expect(
      fixture.instance.usedReferenceUids(first),
      {'a1234567890'},
    );

    fixture.instance.materializeRepeatItem(rows.elements.first);
    expect(
      first.mountedControl?.errors,
      contains(ReferenceValidationMessage.duplicate),
    );

    fixture.instance.removeRepeatedItem(rows.elements.last, rows);

    expect(first.errors, isNot(contains(ReferenceValidationMessage.duplicate)));
    expect(
      first.mountedControl?.errors,
      isNot(contains(ReferenceValidationMessage.duplicate)),
    );
    expect(fixture.instance.usedReferenceUids(first), isEmpty);
    fixture.instance.dispose();
  });

  test('different Reference elements may reuse a UID', () {
    final fixture = _buildFixture(
      initialValue: {
        'topReference': 'a1234567890',
        'rows': [
          {
            'rowReference': 'a1234567890',
            'otherReference': 'a1234567890',
          },
        ],
      },
    );
    final rows = fixture.root.element('rows') as RepeatSection;
    final row = rows.elements.single;
    final rowReference = row.element('rowReference') as ReferenceFieldInstance;
    final otherReference =
        row.element('otherReference') as ReferenceFieldInstance;
    final topReference =
        fixture.root.element('topReference') as ReferenceFieldInstance;

    expect(rowReference.hasDuplicateValue, isFalse);
    expect(otherReference.hasDuplicateValue, isFalse);
    expect(topReference.hasDuplicateValue, isFalse);
    fixture.instance.dispose();
  });

  test('hidden occurrences do not reserve or duplicate a UID', () {
    final fixture = _buildFixture();
    final rows = fixture.root.element('rows') as RepeatSection;
    final first =
        rows.elements.first.element('rowReference') as ReferenceFieldInstance;
    final second =
        rows.elements.last.element('rowReference') as ReferenceFieldInstance;

    second.markAsHidden();

    expect(first.hasDuplicateValue, isFalse);
    expect(second.hasDuplicateValue, isFalse);
    expect(fixture.instance.usedReferenceUids(first), isEmpty);
    fixture.instance.dispose();
  });

  test('nested repeat occurrences participate without eager hydration', () {
    final fixture = _buildFixture(
      initialValue: {
        'rows': [
          {
            'nested': [
              {'nestedReference': 'a1234567890'},
            ],
          },
          {
            'nested': [
              {'nestedReference': 'a1234567890'},
            ],
          },
        ],
      },
    );
    final rows = fixture.root.element('rows') as RepeatSection;
    final firstNested = rows.elements.first.element('nested') as RepeatSection;
    final secondNested = rows.elements.last.element('nested') as RepeatSection;
    final first = firstNested.elements.single.element('nestedReference')
        as ReferenceFieldInstance;
    final second = secondNested.elements.single.element('nestedReference')
        as ReferenceFieldInstance;

    expect(first.mountedControl, isNull);
    expect(second.mountedControl, isNull);
    expect(first.hasDuplicateValue, isTrue);
    expect(second.hasDuplicateValue, isTrue);

    second.markAsHidden();

    expect(first.hasDuplicateValue, isFalse);
    fixture.instance.dispose();
  });
}

({FormInstance instance, Section root}) _buildFixture({
  Map<String, Object?>? initialValue,
}) {
  final value = initialValue ??
      {
        'rows': [
          {'rowReference': 'a1234567890'},
          {'rowReference': 'a1234567890'},
        ],
      };
  final repository = formRepositoryFromJson({
    'uid': 'reference-form-v1',
    'name': 'Reference form',
    'versionUid': 'reference-form-v1',
    'versionNumber': 1,
    'fields': [
      {
        'id': 'top-reference',
        'name': 'topReference',
        'type': 'Reference',
      },
      {
        'id': 'row-reference',
        'name': 'rowReference',
        'parent': 'rows',
        'type': 'Reference',
      },
      {
        'id': 'other-reference',
        'name': 'otherReference',
        'parent': 'rows',
        'type': 'Reference',
      },
      {
        'id': 'nested-reference',
        'name': 'nestedReference',
        'parent': 'nested',
        'type': 'Reference',
      },
    ],
    'sections': [
      {
        'id': 'rows',
        'name': 'rows',
        'repeatable': true,
      },
      {
        'id': 'nested',
        'name': 'nested',
        'parent': 'rows',
        'repeatable': true,
      },
    ],
    'options': <Object?>[],
  });
  final form = FormGroup(
    FormElementControlBuilder.formDataControls(repository, value),
  );
  final root = Section(
    template: repository.rootSection,
    form: form,
    elements: FormElementBuilder.buildFormElements(
      form,
      repository,
      initialFormValue: value,
    ),
  )
    ..bindControlReferences()
    ..resolveDependencies()
    ..evaluate(emitEvent: false);
  final instance = FormInstance(
    submissionId: 'submission-1',
    entryStarted: DateTime.utc(2026, 7, 25),
    enabled: true,
    form: form,
    rootSection: root,
    formFlatTemplate: repository,
    formMetadata: const FormMetadata(
      formId: 'reference-form',
      versionUid: 'reference-form-v1',
      assignmentId: 'assignment-1',
    ),
    fieldKeysRegistery: FieldContextRegistry(),
    initialValue: value,
  );
  return (instance: instance, root: root);
}
