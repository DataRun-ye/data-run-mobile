import 'dart:io';

import 'package:datarunmobile/database/app_database.dart';
import 'package:drift/drift.dart' show Variable;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final sourceVersion in [3, 4, 5, 6]) {
    test('schema $sourceVersion migrates to 7 without losing cached work',
        () async {
      final database = _openProductionDatabase(sourceVersion: sourceVersion);
      addTearDown(database.close);

      final version = await database
          .customSelect('PRAGMA user_version;')
          .map((row) => row.read<int>('user_version'))
          .getSingle();

      expect(version, 7);

      final actualTables = await _tableNames(database);
      for (final table in database.allTables) {
        expect(actualTables, contains(table.actualTableName));

        final actualColumns =
            await _columnNames(database, table.actualTableName);
        expect(
          actualColumns,
          containsAll(table.$columns.map((column) => column.name)),
          reason: 'Missing schema-5 column in ${table.actualTableName}',
        );
      }

      final submission = await (database.select(database.dataInstances)
            ..where((row) => row.id.equals('submission-1')))
          .getSingle();
      expect(submission.formData, {
        'repeat': [
          {'value': 'preserved'}
        ],
      });
      expect(submission.finishedEntryTime, isNull);

      final summary = await (database.select(database.syncSummaries)
            ..where((row) => row.entity.equals('forms')))
          .getSingle();
      expect(summary.lastSuccessfulSync, isNull);

      expect(actualTables, isNot(contains('data_values')));
      expect(actualTables, isNot(contains('repeat_instances')));
      expect(actualTables, isNot(contains('data_elements')));
      expect(actualTables, contains('metadata_submissions'));
      expect(actualTables, contains('reference_entries'));
      expect(
        await _columnNames(database, 'reference_entries'),
        {'uid', 'org_unit_uid', 'display_name'},
      );
      expect(
        await _indexColumns(
          database,
          'reference_entry_scope_name_idx',
        ),
        ['org_unit_uid', 'display_name'],
      );
      expect(
        await database
            .customSelect('SELECT count(*) AS count FROM metadata_submissions;')
            .map((row) => row.read<int>('count'))
            .getSingle(),
        1,
      );
      expect(actualTables, isNot(contains('assignment_manifests')));
      expect(actualTables, isNot(contains('party_sets')));
      expect(actualTables, isNot(contains('parties')));
    });
  }

  test('schema 3 upgrade preserves populated unowned party tables', () async {
    final database = _openProductionDatabase(
      sourceVersion: 3,
      additionalSetup: '''
        CREATE TABLE party_sets (
          id TEXT NOT NULL PRIMARY KEY,
          name TEXT NOT NULL
        );
        INSERT INTO party_sets (id, name)
        VALUES ('legacy-party-set', 'Preserved');
      ''',
    );
    addTearDown(database.close);

    final version = await database
        .customSelect('PRAGMA user_version;')
        .map((row) => row.read<int>('user_version'))
        .getSingle();
    final partySet = await database.customSelect(
      'SELECT id, name FROM party_sets WHERE id = ?',
      variables: [const Variable('legacy-party-set')],
    ).getSingle();

    expect(version, 7);
    expect(partySet.read<String>('name'), 'Preserved');
  });
}

AppDatabase _openProductionDatabase({
  required int sourceVersion,
  String? additionalSetup,
}) {
  assert(sourceVersion >= 3 && sourceVersion <= 6);
  final schema =
      File('test/fixtures/database/schema_v3.sql').readAsStringSync();
  return AppDatabase(
    executor: NativeDatabase.memory(
      setup: (rawDatabase) {
        rawDatabase.execute(schema);
        if (sourceVersion >= 4) {
          rawDatabase.execute(
            'ALTER TABLE sync_summaries '
            'ADD COLUMN last_successful_sync TEXT NULL;',
          );
        }
        if (additionalSetup != null) {
          rawDatabase.execute(additionalSetup);
        }
        rawDatabase.execute(_syntheticProductionRows);
        if (sourceVersion >= 5) {
          rawDatabase.execute('DROP TABLE data_values;');
          rawDatabase.execute('DROP TABLE repeat_instances;');
        }
        if (sourceVersion >= 6) {
          rawDatabase.execute('DROP TABLE data_elements;');
        }
        rawDatabase.execute('PRAGMA user_version = $sourceVersion;');
      },
    ),
    userId: 'migration-test-user',
  );
}

Future<Set<String>> _tableNames(AppDatabase database) async {
  final rows = await database.customSelect('''
    SELECT name
    FROM sqlite_schema
    WHERE type = 'table' AND name NOT LIKE 'sqlite_%';
  ''').get();
  return rows.map((row) => row.read<String>('name')).toSet();
}

Future<Set<String>> _columnNames(
  AppDatabase database,
  String tableName,
) async {
  final rows = await database
      .customSelect('PRAGMA table_info("${tableName.replaceAll('"', '""')}");')
      .get();
  return rows.map((row) => row.read<String>('name')).toSet();
}

Future<List<String>> _indexColumns(
  AppDatabase database,
  String indexName,
) async {
  final rows = await database
      .customSelect('PRAGMA index_info("${indexName.replaceAll('"', '""')}");')
      .get();
  return rows.map((row) => row.read<String>('name')).toList();
}

const _syntheticProductionRows = '''
INSERT INTO org_units (id, translations, name, path, level)
VALUES ('org-1', '{}', 'Org unit', '/org-1', 1);
INSERT INTO projects (id, translations, name)
VALUES ('project-1', '{}', 'Project');
INSERT INTO activities (id, translations, name, project)
VALUES ('activity-1', '{}', 'Activity', 'project-1');
INSERT INTO teams (id, activity)
VALUES ('team-1', 'activity-1');
INSERT INTO assignments (id, activity, team, org_unit, sync_state)
VALUES ('assignment-1', 'activity-1', 'team-1', 'org-1', 'synced');
INSERT INTO form_templates (id, version_uid, version_number, name)
VALUES ('form-1', 'version-1', 1, 'Form');
INSERT INTO assignment_forms (assignment, form, can_add_submissions)
VALUES ('assignment-1', 'form-1', 1);
INSERT INTO form_template_versions
  (id, template, version_number, fields, sections, options)
VALUES ('version-1', 'form-1', 1, '[]', '[]', '[]');
INSERT INTO data_elements (id, translations, name, type)
VALUES ('element-1', '{}', 'Legacy value', 'TEXT');
INSERT INTO data_instances
  (id, deleted, form_template, template_version, assignment,
   start_entry_time, form_data, sync_state, is_to_update)
VALUES
  ('submission-1', 0, 'form-1', 'version-1', 'assignment-1',
   '2026-01-01T00:00:00.000Z',
   '{"repeat":[{"value":"preserved"}]}', 'draft', 0);
INSERT INTO repeat_instances
  (id, submission, template_path, repeat_index)
VALUES ('legacy-repeat-1', 'submission-1', 'repeat', 1);
INSERT INTO data_values
  (id, data_element, data_instance, value)
VALUES ('legacy-value-1', 'element-1', 'submission-1', 'obsolete');
INSERT INTO sync_summaries (entity, success_count, failure_count)
VALUES ('forms', 1, 0);
INSERT INTO metadata_submissions
  (id, resource_type, metadata_schema, serial_number, version, resource_id)
VALUES ('legacy-metadata-1', 'legacy', 'legacy', 1, 1, 'resource-1');
''';
