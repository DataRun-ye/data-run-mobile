import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late ReferenceEntryRepository repository;

  setUp(() async {
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'reference-test-user',
    );
    repository = ReferenceEntryRepository(database);
    await _seedReferenceAssignment(database);
  });

  tearDown(() => database.close());

  test('discovers one sync scope per org unit from current Reference forms',
      () async {
    await database.customStatement('''
      INSERT INTO assignments
        (id, activity, team, org_unit, sync_state, disabled)
      VALUES
        ('assignment-2', 'activity-1', 'team-1', 'org-1', 'synced', 0);
      INSERT INTO assignment_forms
        (assignment, form, can_add_submissions)
      VALUES ('assignment-2', 'form-1', 1);
    ''');

    final scopes = await repository.findSyncScopes();

    expect(scopes, hasLength(1));
    expect(scopes.single.orgUnitUid, 'org-1');
    expect(
      {'assignment-1', 'assignment-2'},
      contains(scopes.single.assignmentUid),
    );
  });

  test('does not discover ordinary, read-only, or disabled assignment work',
      () async {
    final version =
        await database.select(database.formTemplateVersions).getSingle();
    await database.update(database.formTemplateVersions).write(
          version.copyWith(
            fields: [
              FieldTemplate(
                id: 'text-field',
                name: 'textField',
                type: ValueType.Text,
              ),
            ],
          ),
        );
    expect(await repository.findSyncScopes(), isEmpty);

    await database.update(database.formTemplateVersions).write(
          version.copyWith(
            fields: [
              FieldTemplate(
                id: 'reference-field',
                name: 'referenceField',
                type: ValueType.Reference,
              ),
            ],
          ),
        );
    await database.update(database.assignmentForms).write(
          const AssignmentFormsCompanion(
            canAddSubmissions: Value(false),
          ),
        );
    expect(await repository.findSyncScopes(), isEmpty);

    await database.update(database.assignmentForms).write(
          const AssignmentFormsCompanion(
            canAddSubmissions: Value(true),
          ),
        );
    await database.update(database.assignments).write(
          const AssignmentsCompanion(disabled: Value(true)),
        );
    expect(await repository.findSyncScopes(), isEmpty);
  });

  test('upsert refreshes names but retains rows omitted by a server page',
      () async {
    await repository.upsertRemotePage(
      orgUnitUid: 'org-1',
      entries: const [
        ReferenceEntry(
          uid: 'a1234567890',
          orgUnitUid: 'org-1',
          displayName: 'Old Canonical Name Here',
        ),
        ReferenceEntry(
          uid: 'b1234567890',
          orgUnitUid: 'org-1',
          displayName: 'Local Name Stays Here',
        ),
      ],
    );

    await repository.upsertRemotePage(
      orgUnitUid: 'org-1',
      entries: const [
        ReferenceEntry(
          uid: 'a1234567890',
          orgUnitUid: 'org-1',
          displayName: 'New Canonical Name Here',
        ),
      ],
    );

    expect(
      (await repository.findInScope(
        uid: 'a1234567890',
        orgUnitUid: 'org-1',
      ))
          ?.displayName,
      'New Canonical Name Here',
    );
    expect(
      await repository.findInScope(
        uid: 'b1234567890',
        orgUnitUid: 'org-1',
      ),
      isNotNull,
    );
  });

  test('cross-org UID conflict preserves the existing row', () async {
    await repository.upsertRemotePage(
      orgUnitUid: 'org-1',
      entries: const [
        ReferenceEntry(
          uid: 'a1234567890',
          orgUnitUid: 'org-1',
          displayName: 'Canonical Name One Here',
        ),
      ],
    );

    await expectLater(
      repository.upsertRemotePage(
        orgUnitUid: 'org-2',
        entries: const [
          ReferenceEntry(
            uid: 'a1234567890',
            orgUnitUid: 'org-2',
            displayName: 'Conflicting Name Two Here',
          ),
        ],
      ),
      throwsA(isA<ReferenceEntryScopeConflict>()),
    );

    final existing = await repository.findInScope(
      uid: 'a1234567890',
      orgUnitUid: 'org-1',
    );
    expect(existing?.displayName, 'Canonical Name One Here');
  });

  test('search remains bounded with 1500 entries in one org unit', () async {
    final entries = List.generate(
      1500,
      (index) => ReferenceEntry(
        uid: _referenceUid(index),
        orgUnitUid: 'org-1',
        displayName: 'Person ${index.toString().padLeft(4, '0')} Name Here',
      ),
    );
    for (var offset = 0; offset < entries.length; offset += 500) {
      await repository.upsertRemotePage(
        orgUnitUid: 'org-1',
        entries: entries.sublist(offset, offset + 500),
      );
    }

    final result = await repository.search(
      orgUnitUid: 'org-1',
      query: 'Person',
    );

    expect(result, hasLength(50));
    expect(result.first.uid, _referenceUid(0));
    expect(result.last.uid, _referenceUid(49));

    expect(
      await repository.search(
        orgUnitUid: 'org-1',
        query: 'Person',
        limit: 1000,
      ),
      hasLength(ReferenceEntryRepository.maxSearchResults),
    );
  });

  test('finds an entry with the same name once spelling is ignored', () async {
    await repository.upsertRemotePage(orgUnitUid: 'org-1', entries: [
      ReferenceEntry(
        uid: _referenceUid(1),
        orgUnitUid: 'org-1',
        displayName: 'أحمد علي صالح عبد الله',
      ),
      ReferenceEntry(
        uid: _referenceUid(2),
        orgUnitUid: 'org-1',
        displayName: 'فاطمة محمد حسن علي',
      ),
    ]);
    await repository.upsertRemotePage(orgUnitUid: 'org-2', entries: [
      ReferenceEntry(
        uid: _referenceUid(3),
        orgUnitUid: 'org-2',
        displayName: 'احمد علي صالح عبدالله',
      ),
    ]);

    final same = await repository.findSameName(
      orgUnitUid: 'org-1',
      displayName: ' احمد علي  صالح عبدالله ',
    );
    expect(same?.uid, _referenceUid(1));
    expect(
      await repository.findSameName(
        orgUnitUid: 'org-1',
        displayName: 'فاطمه محمد حسن علي',
      ),
      isNotNull,
    );
    expect(
      await repository.findSameName(
        orgUnitUid: 'org-1',
        displayName: 'أحمد علي صالح',
      ),
      isNull,
      reason: 'a shorter name is a different name',
    );
    expect(
      await repository.findSameName(orgUnitUid: 'org-3', displayName: 'احمد'),
      isNull,
    );
  });

  test('search matches spelling variants and words in any order', () async {
    await repository.upsertRemotePage(orgUnitUid: 'org-1', entries: [
      ReferenceEntry(
        uid: _referenceUid(1),
        orgUnitUid: 'org-1',
        displayName: 'أحمد علي صالح',
      ),
      ReferenceEntry(
        uid: _referenceUid(2),
        orgUnitUid: 'org-1',
        displayName: 'فاطمة عبد الله',
      ),
      ReferenceEntry(
        uid: _referenceUid(3),
        orgUnitUid: 'org-1',
        displayName: 'محمد حسن',
      ),
    ]);
    await repository.upsertRemotePage(orgUnitUid: 'org-2', entries: [
      ReferenceEntry(
        uid: _referenceUid(4),
        orgUnitUid: 'org-2',
        displayName: 'احمد صالح',
      ),
    ]);

    Future<List<String>> found(String query) async =>
        (await repository.search(orgUnitUid: 'org-1', query: query))
            .map((entry) => entry.uid)
            .toList();

    expect(await found('احمد صالح'), [_referenceUid(1)]);
    expect(await found('صالح إحمد'), [_referenceUid(1)]);
    expect(await found('فاطمه عبدالله'), [_referenceUid(2)]);
    expect(await found('محمد احمد'), isEmpty);
    expect(await found('  '), hasLength(3));
  });

  test('search limit applies to the matching names', () async {
    final entries = List.generate(
      120,
      (index) => ReferenceEntry(
        uid: _referenceUid(index),
        orgUnitUid: 'org-1',
        displayName: index.isEven
            ? 'بيت ${index.toString().padLeft(3, '0')}'
            : 'منزل ${index.toString().padLeft(3, '0')}',
      ),
    );
    await repository.upsertRemotePage(orgUnitUid: 'org-1', entries: entries);

    final result = await repository.search(
      orgUnitUid: 'org-1',
      query: 'منزل',
      limit: 10,
    );

    expect(result, hasLength(10));
    expect(
        result.every((entry) => entry.displayName.startsWith('منزل')), isTrue);
    expect(result.first.uid, _referenceUid(1));
  });

  test('rejects an oversized remote page before writing', () async {
    final oversizedPage = List.generate(
      ReferenceEntryRepository.maxRemotePageSize + 1,
      (index) => ReferenceEntry(
        uid: _referenceUid(index),
        orgUnitUid: 'org-1',
        displayName: 'Person Name Number Here',
      ),
    );

    await expectLater(
      repository.upsertRemotePage(
        orgUnitUid: 'org-1',
        entries: oversizedPage,
      ),
      throwsArgumentError,
    );
    expect(await database.select(database.referenceEntries).get(), isEmpty);
  });

  test('rejects a malformed UID before writing', () async {
    await expectLater(
      repository.upsertRemotePage(
        orgUnitUid: 'org-1',
        entries: const [
          ReferenceEntry(
            uid: '123',
            orgUnitUid: 'org-1',
            displayName: 'Person Name Number Here',
          ),
        ],
      ),
      throwsFormatException,
    );
    expect(await database.select(database.referenceEntries).get(), isEmpty);
  });
}

Future<void> _seedReferenceAssignment(AppDatabase database) async {
  await database.customStatement('''
    INSERT INTO org_units (id, translations, name, path, level)
    VALUES ('org-1', '{}', 'Org unit', '/org-1', 1);
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
              id: 'reference-field',
              name: 'referenceField',
              type: ValueType.Reference,
            ),
          ],
          sections: const [],
          options: const [],
        ),
      );
  await database.customStatement('''
    INSERT INTO assignment_forms
      (assignment, form, can_add_submissions)
    VALUES ('assignment-1', 'form-1', 1);
  ''');
}

String _referenceUid(int index) => 'r${index.toString().padLeft(10, '0')}';
