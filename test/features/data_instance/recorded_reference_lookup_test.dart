import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/data_instance/application/recorded_reference_lookup.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late RecordedReferenceLookup lookup;

  setUp(() async {
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'recorded-lookup-test-user',
    );
    lookup = RecordedReferenceLookup(database);
    await _seed(database);
  });

  tearDown(() => database.close());

  Future<void> insertSubmission({
    required String id,
    required String household,
    String form = 'form-1',
    String version = 'version-1',
    String assignment = 'assignment-1',
    bool deleted = false,
    required DateTime startedAt,
  }) {
    return database.into(database.dataInstances).insert(
          DataInstancesCompanion.insert(
            id: id,
            formTemplate: form,
            templateVersion: version,
            assignment: Value(assignment),
            syncState: InstanceSyncStatus.finalized,
            isToUpdate: false,
            deleted: Value(deleted),
            startEntryTime: Value(startedAt),
            formData: Value({
              'household': household,
              'members': [
                {'member': 'r000000000m'},
              ],
            }),
          ),
        );
  }

  test('reports households recorded in other submissions of the village',
      () async {
    await insertSubmission(
        id: 'current',
        household: 'r0000000001',
        startedAt: DateTime.utc(2026, 11, 23, 8));
    await insertSubmission(
        id: 'earlier',
        household: 'r0000000002',
        startedAt: DateTime.utc(2026, 11, 23, 9));
    await insertSubmission(
        id: 'return-visit',
        household: 'r0000000002',
        startedAt: DateTime.utc(2026, 11, 24, 10));
    await insertSubmission(
        id: 'old-version',
        household: 'r0000000003',
        version: 'version-0',
        startedAt: DateTime.utc(2026, 11, 22));

    final recorded = await lookup.recordedElsewhere(
      formId: 'form-1',
      orgUnitUid: 'org-1',
      excludeSubmissionId: 'current',
    );

    expect(recorded, {
      'r0000000002': DateTime.utc(2026, 11, 24, 10),
      'r0000000003': DateTime.utc(2026, 11, 22),
      'r000000000m': DateTime.utc(2026, 11, 24, 10),
    });
  });

  test('ignores deleted submissions, other villages and other forms', () async {
    await insertSubmission(
        id: 'deleted',
        household: 'r0000000004',
        deleted: true,
        startedAt: DateTime.utc(2026, 11, 23));
    await insertSubmission(
        id: 'other-village',
        household: 'r0000000005',
        assignment: 'assignment-2',
        startedAt: DateTime.utc(2026, 11, 23));
    await insertSubmission(
        id: 'other-form',
        household: 'r0000000006',
        form: 'form-2',
        startedAt: DateTime.utc(2026, 11, 23));

    final recorded = await lookup.recordedElsewhere(
      formId: 'form-1',
      orgUnitUid: 'org-1',
      excludeSubmissionId: 'current',
    );

    expect(recorded, isEmpty);
  });

  test('skips a submission whose form version is not on the phone', () async {
    await insertSubmission(
        id: 'missing-version',
        household: 'r0000000007',
        version: 'version-gone',
        startedAt: DateTime.utc(2026, 11, 23));

    final recorded = await lookup.recordedElsewhere(
      formId: 'form-1',
      orgUnitUid: 'org-1',
      excludeSubmissionId: 'current',
    );

    expect(recorded, isEmpty);
  });
}

Future<void> _seed(AppDatabase database) async {
  await database.customStatement('''
    INSERT INTO org_units (id, translations, name, path, level)
    VALUES
      ('org-1', '{}', 'Village one', '/org-1', 1),
      ('org-2', '{}', 'Village two', '/org-2', 1);
    INSERT INTO projects (id, translations, name)
    VALUES ('project-1', '{}', 'Project');
    INSERT INTO activities (id, translations, name, project)
    VALUES ('activity-1', '{}', 'Activity', 'project-1');
    INSERT INTO teams (id, activity)
    VALUES ('team-1', 'activity-1');
    INSERT INTO assignments
      (id, activity, team, org_unit, sync_state, disabled)
    VALUES
      ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced', 0),
      ('assignment-2', 'activity-1', 'team-1', 'org-2', 'synced', 0);
    INSERT INTO form_templates (id, version_uid, version_number, name)
    VALUES
      ('form-1', 'version-1', 1, 'Households'),
      ('form-2', 'version-2', 1, 'Other form');
  ''');
  for (final (id, form, number) in [
    ('version-0', 'form-1', 0),
    ('version-1', 'form-1', 1),
    ('version-2', 'form-2', 1),
  ]) {
    await database.into(database.formTemplateVersions).insert(
          FormTemplateVersion(
            id: id,
            template: form,
            versionNumber: number,
            fields: [
              FieldTemplate(
                id: 'household',
                name: 'household',
                type: ValueType.Reference,
              ),
              FieldTemplate(
                id: 'member',
                name: 'member',
                parent: 'members',
                type: ValueType.Reference,
              ),
            ],
            sections: [
              SectionTemplate(
                id: 'members',
                name: 'members',
                path: 'members',
                repeatable: true,
              ),
            ],
            options: const [],
          ),
        );
  }
}
