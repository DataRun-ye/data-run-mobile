import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/section_template.entity.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/features/data_instance/application/reference_upload_payload_builder.dart';
import 'package:datarunmobile/features/data_instance/application/reference_value_extractor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late _CountingReferenceEntryRepository repository;
  late ReferenceUploadPayloadBuilder builder;

  setUp(() async {
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'reference-upload-test',
    );
    repository = _CountingReferenceEntryRepository(database);
    builder = ReferenceUploadPayloadBuilder(
      database,
      repository: repository,
    );
    await _insertTemplate(database);
    await _insertAssignment(database);
  });

  tearDown(() => database.close());

  test('adds deduplicated definitions for ordinary and nested References',
      () async {
    await repository.upsertRemotePage(
      orgUnitUid: 'org-1',
      entries: const [
        ReferenceEntry(
          uid: 'a1234567890',
          orgUnitUid: 'org-1',
          displayName: 'First Display Name Here',
        ),
        ReferenceEntry(
          uid: 'b1234567890',
          orgUnitUid: 'org-1',
          displayName: 'Second Display Name Here',
        ),
      ],
    );
    final submission = _submission(
      formData: {
        'topReference': 'a1234567890',
        'rows': [
          {
            'rowReference': 'a1234567890',
            'nested': [
              {'nestedReference': 'b1234567890'},
            ],
          },
        ],
      },
    );

    final payload = (await builder.build([submission])).single;

    expect(
      payload['referenceDefinitions'],
      [
        {'uid': 'a1234567890', 'name': 'First Display Name Here'},
        {'uid': 'b1234567890', 'name': 'Second Display Name Here'},
      ],
    );
    expect(repository.lookupCalls, 1);
  });

  test('omits an unresolved definition while preserving its form value',
      () async {
    final submission = _submission(
      formData: {'topReference': 'a1234567890'},
    );

    final payload = (await builder.build([submission])).single;

    expect(payload, isNot(contains('referenceDefinitions')));
    expect(payload['formData'], {'topReference': 'a1234567890'});
  });

  test('does not define a UID cached under another org unit', () async {
    await repository.upsertRemotePage(
      orgUnitUid: 'org-2',
      entries: const [
        ReferenceEntry(
          uid: 'a1234567890',
          orgUnitUid: 'org-2',
          displayName: 'Wrong Scope Display Name',
        ),
      ],
    );

    final payload = (await builder.build([
      _submission(formData: {'topReference': 'a1234567890'}),
    ]))
        .single;

    expect(payload, isNot(contains('referenceDefinitions')));
    expect(payload['formData'], {'topReference': 'a1234567890'});
  });

  test('rejects malformed Reference UIDs before the network request', () {
    final submission = _submission(
      formData: {'topReference': 'not-a-uid'},
    );

    expect(() => builder.build([submission]), throwsFormatException);
  });

  test('resolves 250 repeat References in one bounded catalog lookup',
      () async {
    final entries = List.generate(
      250,
      (index) => ReferenceEntry(
        uid: _referenceUid(index),
        orgUnitUid: 'org-1',
        displayName: 'Reference Person Name $index',
      ),
    );
    await repository.upsertRemotePage(
      orgUnitUid: 'org-1',
      entries: entries,
    );
    final submission = _submission(
      formData: {
        'rows': [
          for (final entry in entries) {'rowReference': entry.uid},
        ],
      },
    );

    final payload = (await builder.build([submission])).single;

    expect(payload['referenceDefinitions'], hasLength(250));
    expect(repository.lookupCalls, 1);
    expect(repository.largestLookup, 250);
  });

  test('builds one immutable template graph per pinned version', () async {
    final recordingExtractor = _RecordingReferenceValueExtractor();
    final recordingBuilder = ReferenceUploadPayloadBuilder(
      database,
      repository: repository,
      extractor: recordingExtractor,
    );

    await recordingBuilder.build([
      _submission(formData: const {}),
      _submission(id: 'submission-2', formData: const {}),
    ]);

    expect(recordingExtractor.templates, hasLength(2));
    expect(
      identical(
        recordingExtractor.templates.first,
        recordingExtractor.templates.last,
      ),
      isTrue,
    );
  });
}

class _CountingReferenceEntryRepository extends ReferenceEntryRepository {
  _CountingReferenceEntryRepository(super.database);

  int lookupCalls = 0;
  int largestLookup = 0;

  @override
  Future<List<ReferenceEntry>> findByUids(Set<String> uids) {
    lookupCalls++;
    if (uids.length > largestLookup) {
      largestLookup = uids.length;
    }
    return super.findByUids(uids);
  }
}

class _RecordingReferenceValueExtractor extends ReferenceValueExtractor {
  final List<FormTemplateModel> templates = [];

  @override
  List<ReferenceValueOccurrence> extract({
    required FormTemplateModel template,
    required Map<String, dynamic>? formData,
  }) {
    templates.add(template);
    return super.extract(template: template, formData: formData);
  }
}

Future<void> _insertTemplate(AppDatabase database) async {
  await database.customStatement('''
    INSERT INTO form_templates
      (id, version_uid, version_number, name)
    VALUES ('form-1', 'version-1', 1, 'Reference form');
  ''');
  await database.into(database.formTemplateVersions).insert(
        FormTemplateVersion(
          id: 'version-1',
          template: 'form-1',
          versionNumber: 1,
          fields: [
            FieldTemplate(
              id: 'top-reference',
              name: 'topReference',
              type: ValueType.Reference,
            ),
            FieldTemplate(
              id: 'row-reference',
              name: 'rowReference',
              parent: 'rows',
              type: ValueType.Reference,
            ),
            FieldTemplate(
              id: 'nested-reference',
              name: 'nestedReference',
              parent: 'nested',
              type: ValueType.Reference,
            ),
          ],
          sections: [
            SectionTemplate(
              id: 'rows',
              name: 'rows',
              path: 'rows',
              repeatable: true,
            ),
            SectionTemplate(
              id: 'nested',
              name: 'nested',
              path: 'rows.nested',
              parent: 'rows',
              repeatable: true,
            ),
          ],
          options: const [],
        ),
      );
}

Future<void> _insertAssignment(AppDatabase database) async {
  await database.customStatement('''
    INSERT INTO org_units (id, translations, name, path, level)
    VALUES
      ('org-1', '{}', 'Org one', '/org-1', 1),
      ('org-2', '{}', 'Org two', '/org-2', 1);
    INSERT INTO projects (id, translations, name)
    VALUES ('project-1', '{}', 'Project');
    INSERT INTO activities (id, translations, name, project)
    VALUES ('activity-1', '{}', 'Activity', 'project-1');
    INSERT INTO teams (id, activity)
    VALUES ('team-1', 'activity-1');
    INSERT INTO assignments
      (id, activity, team, org_unit, sync_state, disabled)
    VALUES
      ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced', 0);
  ''');
}

DataInstance _submission({
  String id = 'submission-1',
  required Map<String, dynamic> formData,
}) {
  return DataInstance(
    id: id,
    formTemplate: 'form-1',
    templateVersion: 'version-1',
    assignment: 'assignment-1',
    syncState: InstanceSyncStatus.finalized,
    formData: formData,
    isToUpdate: false,
    deleted: false,
    startEntryTime: DateTime.utc(2026, 7, 25),
  );
}

String _referenceUid(int index) => 'r${index.toString().padLeft(10, '0')}';
