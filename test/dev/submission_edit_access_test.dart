import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/form_submission/application/submission_edit_access.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
  });

  tearDown(() => db.close());

  test('local submissions remain editable without server edit permission',
      () async {
    await _insertAccess(db, canEditSynced: false);
    await _insertSubmission(
      db,
      id: 'local-submission',
      syncState: InstanceSyncStatus.draft,
    );

    expect(
      await canEditSubmission(db, submissionId: 'local-submission'),
      isTrue,
    );
  });

  test('synced submissions require explicit server edit permission', () async {
    await _insertAccess(db, canEditSynced: false);
    await _insertSubmission(
      db,
      id: 'synced-submission',
      syncState: InstanceSyncStatus.synced,
    );

    expect(
      await canEditSubmission(db, submissionId: 'synced-submission'),
      isFalse,
    );

    await db.managers.assignmentForms
        .filter((filter) =>
            filter.assignment.id('assignment-1') & filter.form.id('form-1'))
        .update((row) => row(canEditSubmissions: const Value(true)));

    expect(
      await canEditSubmission(db, submissionId: 'synced-submission'),
      isTrue,
    );
  });
}

Future<void> _insertAccess(
  AppDatabase db, {
  required bool canEditSynced,
}) {
  return db.into(db.assignmentForms).insert(
        AssignmentFormsCompanion.insert(
          assignment: 'assignment-1',
          form: 'form-1',
          canEditSubmissions: Value(canEditSynced),
        ),
      );
}

Future<void> _insertSubmission(
  AppDatabase db, {
  required String id,
  required InstanceSyncStatus syncState,
}) {
  return db.into(db.dataInstances).insert(
        DataInstancesCompanion.insert(
          id: id,
          formTemplate: 'form-1',
          templateVersion: 'version-1',
          assignment: const Value('assignment-1'),
          syncState: syncState,
          isToUpdate: syncState.isSynced,
        ),
      );
}
