import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/data_instance/application/submission_table_service.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_service.dart';
import 'package:datarunmobile/features/data_instance/application/table_controller.provider.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late _DelayedSubmissionTableService service;
  late ProviderContainer container;

  setUp(() async {
    await appLocator.reset();
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    service = _DelayedSubmissionTableService(
      database: db,
      uploadService: SubmissionUploadService(
        database: db,
        apiClient: _UnusedHttpClient(),
        operationTracker: SessionOperationTracker(),
      ),
    );
    appLocator.registerSingleton<SubmissionTableService>(service);
    container = ProviderContainer();
  });

  tearDown(() async {
    container.dispose();
    await appLocator.reset();
    await db.close();
  });

  test('selection is owned by one form and assignment table scope', () {
    final first = tableControllerProvider(
      formId: 'form-1',
      assignmentId: 'assignment-1',
    );
    final second = tableControllerProvider(
      formId: 'form-1',
      assignmentId: 'assignment-2',
    );
    final firstSubscription = container.listen(first, (_, __) {});
    final secondSubscription = container.listen(second, (_, __) {});

    container.read(first.notifier).toggleSelection('submission-1');

    expect(container.read(first), {'submission-1'});
    expect(container.read(second), isEmpty);

    firstSubscription.close();
    secondSubscription.close();
  });

  test('delete finishes safely if the table scope closes while awaiting',
      () async {
    await _seedSubmission(db);
    final provider = tableControllerProvider(
      formId: 'form-1',
      assignmentId: null,
    );
    final subscription = container.listen(provider, (_, __) {});
    final controller = container.read(provider.notifier);
    controller.toggleSelection('submission-1');

    final deletion = controller.deleteSelectedItems();
    await service.deleteStarted.future;
    subscription.close();
    await container.pump();
    service.continueDelete.complete();

    await expectLater(deletion, completes);
    expect(await db.dataInstancesDao.getById('submission-1'), isNull);
  });
}

Future<void> _seedSubmission(AppDatabase db) async {
  await db.into(db.formTemplates).insert(
        FormTemplatesCompanion.insert(
          id: 'form-1',
          versionUid: 'version-1',
          versionNumber: 1,
          name: 'Form',
        ),
      );
  await db.into(db.formTemplateVersions).insert(
        FormTemplateVersionsCompanion.insert(
          id: 'version-1',
          template: 'form-1',
          versionNumber: 1,
          fields: const <Template>[],
          sections: const <Template>[],
        ),
      );
  await db.into(db.dataInstances).insert(
        DataInstancesCompanion.insert(
          id: 'submission-1',
          formTemplate: 'form-1',
          templateVersion: 'version-1',
          syncState: InstanceSyncStatus.draft,
          isToUpdate: false,
        ),
      );
}

class _DelayedSubmissionTableService extends SubmissionTableService {
  _DelayedSubmissionTableService({
    required super.database,
    required super.uploadService,
  });

  final deleteStarted = Completer<void>();
  final continueDelete = Completer<void>();

  @override
  Future<int> delete(Iterable<String> ids) async {
    deleteStarted.complete();
    await continueDelete.future;
    return super.delete(ids);
  }
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
    throw UnimplementedError('Upload is not exercised by these tests');
  }
}
