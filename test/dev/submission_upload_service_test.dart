import 'dart:async';

import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/data_instance/repeat_metadata_normalizer.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_service.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late _FakeHttpClient apiClient;
  late SessionOperationTracker operationTracker;
  late SubmissionUploadService service;

  setUp(() {
    db = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
    apiClient = _FakeHttpClient();
    operationTracker = SessionOperationTracker();
    service = SubmissionUploadService(
      database: db,
      apiClient: apiClient,
      operationTracker: operationTracker,
    );
  });

  tearDown(() => db.close());

  test('uploads finalized rows with persisted repeat metadata', () async {
    await _insertSubmission(
      db,
      id: 'submission-1',
      syncState: InstanceSyncStatus.finalized,
      formData: {
        'households': [
          {'name': 'Household A'},
        ],
      },
    );
    await _insertSubmission(
      db,
      id: 'draft-1',
      syncState: InstanceSyncStatus.draft,
      formData: const {},
    );
    apiClient.responseData = {
      'created': ['submission-1'],
      'updated': <String>[],
      'failed': <String, dynamic>{},
    };

    final result = await service.upload(['submission-1', 'draft-1']);

    expect(result.created, ['submission-1']);
    expect(apiClient.resourceName, 'dataSubmission/bulk');
    expect(apiClient.method, 'post');

    final payload = (apiClient.data as List).cast<Map<String, dynamic>>();
    expect(payload, hasLength(1));
    final uploadedFormData = payload.single['formData'] as Map<String, dynamic>;
    final uploadedRow =
        (uploadedFormData['households'] as List).single as Map<String, dynamic>;
    expect(uploadedRow[RepeatMetadataNormalizer.idKey], hasLength(26));
    expect(uploadedRow[RepeatMetadataNormalizer.parentIdKey], 'submission-1');
    expect(
      uploadedRow[RepeatMetadataNormalizer.submissionUidKey],
      'submission-1',
    );

    final saved = await db.dataInstancesDao.getById('submission-1');
    final savedRow =
        (saved!.formData!['households'] as List).single as Map<String, dynamic>;
    expect(
      savedRow[RepeatMetadataNormalizer.idKey],
      uploadedRow[RepeatMetadataNormalizer.idKey],
    );
    expect(saved.syncState, InstanceSyncStatus.synced);
    expect(saved.isToUpdate, isTrue);
    expect(saved.lastSyncMessage, isNull);
    expect(saved.lastSyncDate, isNotNull);

    final draft = await db.dataInstancesDao.getById('draft-1');
    expect(draft!.syncState, InstanceSyncStatus.draft);
  });

  test('marks prepared rows failed when the request throws', () async {
    await _insertSubmission(
      db,
      id: 'submission-2',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.error = StateError('offline');

    final result = await service.upload(['submission-2']);

    expect(result.created, isEmpty);
    expect(result.updated, isEmpty);
    expect(result.failed, isEmpty);
    final saved = await db.dataInstancesDao.getById('submission-2');
    expect(saved!.syncState, InstanceSyncStatus.syncFailed);
    expect(saved.isToUpdate, isFalse);
    expect(saved.lastSyncMessage, contains('offline'));
    expect(saved.lastSyncDate, isNotNull);
  });

  test('session drain waits until a rejected upload is marked failed',
      () async {
    await _insertSubmission(
      db,
      id: 'submission-expired',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.requestStarted = Completer<void>();
    apiClient.releaseRequest = Completer<void>();
    apiClient.error = RevokeTokenException(
      requestOptions: RequestOptions(path: '/dataSubmission/bulk'),
    );

    final upload = service.upload(['submission-expired']);
    await apiClient.requestStarted!.future;
    var drainCompleted = false;
    final drain = operationTracker.stopAndWaitForIdle().then((_) {
      drainCompleted = true;
    });

    await Future<void>.delayed(Duration.zero);
    expect(drainCompleted, isFalse);

    apiClient.releaseRequest!.complete();
    await upload;
    await drain;

    final saved = await db.dataInstancesDao.getById('submission-expired');
    expect(saved!.syncState, InstanceSyncStatus.syncFailed);
    expect(drainCompleted, isTrue);
  });
}

Future<void> _insertSubmission(
  AppDatabase db, {
  required String id,
  required InstanceSyncStatus syncState,
  required Map<String, dynamic> formData,
}) async {
  await db.into(db.dataInstances).insert(
        DataInstancesCompanion.insert(
          id: id,
          formTemplate: 'form-1',
          templateVersion: 'version-1',
          syncState: syncState,
          isToUpdate: false,
          formData: Value(formData),
        ),
      );
}

class _FakeHttpClient extends HttpClient<dynamic> {
  Map<String, dynamic> responseData = const {};
  Object? error;
  Completer<void>? requestStarted;
  Completer<void>? releaseRequest;
  String? resourceName;
  String? method;
  Object? data;

  @override
  Future<Response<dynamic>> request({
    required String resourceName,
    String? path,
    required String method,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    this.resourceName = resourceName;
    this.method = method;
    this.data = data;
    requestStarted?.complete();
    await releaseRequest?.future;
    final requestError = error;
    if (requestError != null) throw requestError;
    return Response<dynamic>(
      data: responseData,
      requestOptions: RequestOptions(path: resourceName),
    );
  }
}
