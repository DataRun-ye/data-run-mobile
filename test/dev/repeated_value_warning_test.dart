import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/builder/form_element_builder.dart';
import 'package:datarunmobile/core/form/builder/form_element_control_builder.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'support/form_template_fixture.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    await S.load(const Locale('en'));
    await appLocator.reset();
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'repeated-value-test',
    );
    appLocator.registerSingleton<AppDatabase>(database);
  });

  tearDown(() async {
    await database.close();
    await appLocator.reset();
  });

  FieldInstance<dynamic> cardOf(Section root, int row) =>
      ((root.element('rows') as RepeatSection).elements[row].element('card'))
          as FieldInstance<dynamic>;

  test('a card number repeated in another row warns until the row is removed',
      () {
    final fixture = _buildFixture(rows: [
      {'card': '100', 'note': 'same'},
      {'card': '100', 'note': 'same'},
      {'card': '101', 'note': 'other'},
    ]);
    final rows = fixture.root.element('rows') as RepeatSection;
    final note = rows.elements.first.element('note') as FieldInstance<dynamic>;

    expect(cardOf(fixture.root, 0).elementState.warning,
        S.current.valueRepeatedInForm);
    expect(cardOf(fixture.root, 1).elementState.warning,
        S.current.valueRepeatedInForm);
    expect(cardOf(fixture.root, 2).elementState.warning, isEmpty);
    expect(note.elementState.warning, isEmpty);

    fixture.instance.removeRepeatedItem(rows.elements[1], rows);

    expect(cardOf(fixture.root, 0).elementState.warning, isEmpty);
    fixture.instance.dispose();
  });

  test('a card number recorded in another submission of the village warns',
      () async {
    await _seedOtherSubmission(database, card: '101');

    final fixture = _buildFixture(rows: [
      {'card': '١٠١'},
      {'card': '102'},
    ]);
    final card = cardOf(fixture.root, 0);
    for (var i = 0; i < 50 && card.elementState.warning.isEmpty; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }

    expect(
        card.elementState.warning, S.current.valueRecordedBefore('2026-11-23'));
    expect(cardOf(fixture.root, 1).elementState.warning, isEmpty);
    fixture.instance.dispose();
  });
}

const _cardField = {
  'id': 'card-id',
  'name': 'card',
  'parent': 'rows',
  'type': 'Text',
  'properties': {'warnIfRepeated': true},
};
const _noteField = {
  'id': 'note-id',
  'name': 'note',
  'parent': 'rows',
  'type': 'Text',
};
const _rowsSection = {'id': 'rows', 'name': 'rows', 'repeatable': true};

({FormInstance instance, Section root}) _buildFixture({
  required List<Map<String, Object?>> rows,
}) {
  final value = <String, Object?>{'rows': rows};
  final repository = formRepositoryFromJson({
    'uid': 'card-form',
    'name': 'Card form',
    'versionUid': 'card-form-v1',
    'versionNumber': 1,
    'fields': [_cardField, _noteField],
    'sections': [_rowsSection],
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
    entryStarted: DateTime.utc(2026, 11, 24),
    enabled: true,
    form: form,
    rootSection: root,
    formFlatTemplate: repository,
    formMetadata: const FormMetadata(
      formId: 'card-form',
      versionUid: 'card-form-v1',
      assignmentId: 'assignment-1',
    ),
    fieldKeysRegistery: FieldContextRegistry(),
    initialValue: value,
  );
  return (instance: instance, root: root);
}

Future<void> _seedOtherSubmission(
  AppDatabase database, {
  required String card,
}) async {
  await database.customStatement('''
    INSERT INTO org_units (id, translations, name, path, level)
    VALUES ('org-1', '{}', 'Village', '/org-1', 1);
    INSERT INTO projects (id, translations, name)
    VALUES ('project-1', '{}', 'Project');
    INSERT INTO activities (id, translations, name, project)
    VALUES ('activity-1', '{}', 'Activity', 'project-1');
    INSERT INTO teams (id, activity)
    VALUES ('team-1', 'activity-1');
    INSERT INTO assignments
      (id, activity, team, org_unit, sync_state, disabled)
    VALUES ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced', 0);
    INSERT INTO form_templates (id, version_uid, version_number, name)
    VALUES ('card-form', 'card-form-v1', 1, 'Card form');
  ''');
  await database.into(database.formTemplateVersions).insert(
        FormTemplateVersion(
          id: 'card-form-v1',
          template: 'card-form',
          versionNumber: 1,
          fields: [
            FieldTemplate(
              id: 'card-id',
              name: 'card',
              parent: 'rows',
              type: ValueType.Text,
            ),
          ],
          sections: [
            SectionTemplate(
              id: 'rows',
              name: 'rows',
              path: 'rows',
              repeatable: true,
            ),
          ],
          options: const [],
        ),
      );
  await database.into(database.dataInstances).insert(
        DataInstancesCompanion.insert(
          id: 'submission-0',
          formTemplate: 'card-form',
          templateVersion: 'card-form-v1',
          assignment: const Value('assignment-1'),
          syncState: InstanceSyncStatus.synced,
          isToUpdate: true,
          startEntryTime: Value(DateTime(2026, 11, 23, 9)),
          formData: Value({
            'rows': [
              {'card': card},
            ],
          }),
        ),
      );
}
