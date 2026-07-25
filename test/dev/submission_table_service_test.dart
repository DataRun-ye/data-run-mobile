import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/submissions_filter.dart';
import 'package:datarunmobile/features/data_instance/application/submission_table_service.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_service.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late SubmissionTableService service;

  setUp(() async {
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    service = SubmissionTableService(
      database: db,
      uploadService: SubmissionUploadService(
        database: db,
        apiClient: _UnusedHttpClient(),
        operationTracker: SessionOperationTracker(),
      ),
    );
    await _seedSubmissionTable(db);
  });

  tearDown(() => db.close());

  test('returns a paged submission summary with the full filtered count',
      () async {
    const filter = SubmissionsFilter(formId: 'form-1');

    final result = await service.fetchByFilter(
      filter,
      page: 0,
      pageSize: 1,
    );

    expect(result.totalCount, 2);
    expect(result.items.map((item) => item.id), ['submission-new']);
    expect(await service.countByFilter(filter).getSingle(), 2);
  });

  test('resolves syncable selections and deletes local-only rows', () async {
    await db.into(db.dataInstances).insert(
          DataInstancesCompanion.insert(
            id: 'submission-final',
            formTemplate: 'form-1',
            templateVersion: 'version-1',
            assignment: const Value('assignment-1'),
            syncState: InstanceSyncStatus.finalized,
            isToUpdate: false,
          ),
        );

    final ids = ISet([
      'submission-old',
      'submission-new',
      'submission-final',
    ]);

    expect(await service.getSyncableIds(ids), ['submission-final']);
    expect(await service.canDeleteLocalOnly(['submission-old']), isTrue);
    final deletion = await service.deleteLocalOnly(['submission-old']);

    expect(deletion, LocalSubmissionDeletionResult.deleted);
    expect(await db.dataInstancesDao.getById('submission-old'), isNull);
  });

  test('keeps synced and uploading rows on the device', () async {
    await db.batch((batch) {
      batch.insertAll(db.dataInstances, [
        DataInstancesCompanion.insert(
          id: 'submission-synced',
          formTemplate: 'form-1',
          templateVersion: 'version-1',
          assignment: const Value('assignment-1'),
          syncState: InstanceSyncStatus.synced,
          isToUpdate: true,
        ),
        DataInstancesCompanion.insert(
          id: 'submission-uploading',
          formTemplate: 'form-1',
          templateVersion: 'version-1',
          assignment: const Value('assignment-1'),
          syncState: InstanceSyncStatus.uploading,
          isToUpdate: false,
        ),
      ]);
    });

    expect(await service.canDeleteLocalOnly(['submission-synced']), isFalse);
    expect(await service.canDeleteLocalOnly(['submission-uploading']), isFalse);

    final synced = await service.deleteLocalOnly(['submission-synced']);
    final uploading = await service.deleteLocalOnly(['submission-uploading']);
    expect(
      synced,
      LocalSubmissionDeletionResult.blockedByServerRetention,
    );
    expect(
      uploading,
      LocalSubmissionDeletionResult.blockedByServerRetention,
    );
    expect(await db.dataInstancesDao.getById('submission-synced'), isNotNull);
    expect(
        await db.dataInstancesDao.getById('submission-uploading'), isNotNull);
  });

  test('mixed deletion is all-or-nothing when a protected row is selected',
      () async {
    await db.into(db.dataInstances).insert(
          DataInstancesCompanion.insert(
            id: 'submission-synced',
            formTemplate: 'form-1',
            templateVersion: 'version-1',
            assignment: const Value('assignment-1'),
            syncState: InstanceSyncStatus.synced,
            isToUpdate: true,
          ),
        );

    final selection = ['submission-old', 'submission-synced'];
    expect(await service.canDeleteLocalOnly(selection), isFalse);
    final result = await service.deleteLocalOnly(selection);

    expect(
      result,
      LocalSubmissionDeletionResult.blockedByServerRetention,
    );
    expect(await db.dataInstancesDao.getById('submission-old'), isNotNull);
    expect(await db.dataInstancesDao.getById('submission-synced'), isNotNull);
  });

  test('keeps a server-retained submission after it returns to draft',
      () async {
    await db.into(db.dataInstances).insert(
          DataInstancesCompanion.insert(
            id: 'submission-server-retained-draft',
            formTemplate: 'form-1',
            templateVersion: 'version-1',
            assignment: const Value('assignment-1'),
            syncState: InstanceSyncStatus.draft,
            isToUpdate: true,
          ),
        );

    final result =
        await service.deleteLocalOnly(['submission-server-retained-draft']);

    expect(
      result,
      LocalSubmissionDeletionResult.blockedByServerRetention,
    );
    expect(
      await db.dataInstancesDao.getById('submission-server-retained-draft'),
      isNotNull,
    );
  });
}

Future<void> _seedSubmissionTable(AppDatabase db) async {
  await db.batch((batch) {
    batch.insert(
      db.orgUnits,
      OrgUnitsCompanion.insert(
        id: 'org-unit-1',
        name: 'Org unit',
        path: 'org-unit-1',
        level: 1,
      ),
    );
    batch.insert(
      db.assignments,
      AssignmentsCompanion.insert(
        id: 'assignment-1',
        activity: 'activity-1',
        team: 'team-1',
        orgUnit: 'org-unit-1',
        syncState: InstanceSyncStatus.synced,
      ),
    );
    batch.insert(
      db.formTemplates,
      FormTemplatesCompanion.insert(
        id: 'form-1',
        versionUid: 'version-1',
        versionNumber: 1,
        name: 'Form',
      ),
    );
    batch.insert(
      db.formTemplateVersions,
      FormTemplateVersionsCompanion.insert(
        id: 'version-1',
        template: 'form-1',
        versionNumber: 1,
        fields: const <Template>[],
        sections: const <Template>[],
      ),
    );
    batch.insertAll(db.dataInstances, [
      DataInstancesCompanion.insert(
        id: 'submission-old',
        formTemplate: 'form-1',
        templateVersion: 'version-1',
        assignment: const Value('assignment-1'),
        createdDate: Value(DateTime.utc(2026, 1, 1)),
        syncState: InstanceSyncStatus.draft,
        isToUpdate: false,
      ),
      DataInstancesCompanion.insert(
        id: 'submission-new',
        formTemplate: 'form-1',
        templateVersion: 'version-1',
        assignment: const Value('assignment-1'),
        createdDate: Value(DateTime.utc(2026, 1, 2)),
        syncState: InstanceSyncStatus.draft,
        isToUpdate: false,
      ),
    ]);
  });
}

class _UnusedHttpClient extends HttpClient<dynamic> {
  @override
  Future<Response<dynamic>> request({
    required String resourceName,
    String? path,
    required String method,
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    throw UnimplementedError('Upload is covered by submission upload tests');
  }
}
