import 'dart:async';

import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/data_instance/repeat_metadata_normalizer.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';
import 'package:datarunmobile/core/exception/failure_snapshot.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/http/http_client.dart';
import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/database/shared/value_type.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_service.dart';
import 'package:datarunmobile/features/data_instance/application/submission_upload_result.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late _FakeHttpClient apiClient;
  late SessionOperationTracker operationTracker;
  late SubmissionUploadService service;

  setUp(() async {
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
    await _insertTemplate(db);
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

    expect(result.outcome, SubmissionUploadOutcome.complete);
    expect(result.summary.created, ['submission-1']);
    expect(
      apiClient.resourceName,
      'dataSubmission/bulk?referenceVersion=1',
    );
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
    apiClient.error = NetworkHttpError.fromDioException(
      DioException(
        requestOptions: RequestOptions(path: '/dataSubmission/bulk'),
        type: DioExceptionType.connectionError,
        message: 'SocketException: offline',
      ),
    );

    final result = await service.upload(['submission-2']);

    expect(result.outcome, SubmissionUploadOutcome.requestFailure);
    expect(
      result.failure?.errorCode,
      DRunErrorCode.networkConnectionFailed,
    );
    final saved = await db.dataInstancesDao.getById('submission-2');
    expect(saved!.syncState, InstanceSyncStatus.syncFailed);
    expect(saved.isToUpdate, isFalse);
    final storedFailure = FailureSnapshot.tryDecode(saved.lastSyncMessage);
    expect(
      storedFailure?.errorCode,
      DRunErrorCode.networkConnectionFailed,
    );
    expect(saved.lastSyncMessage, isNot(contains('SocketException')));
    expect(saved.lastSyncDate, isNotNull);
  });

  test('partial response syncs successes and records typed row rejection',
      () async {
    await _insertSubmission(
      db,
      id: 'submission-created',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    await _insertSubmission(
      db,
      id: 'submission-rejected',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.responseData = {
      'created': ['submission-created'],
      'updated': <String>[],
      'failed': {
        'submission-rejected': 'The submission contains invalid values',
      },
    };

    final result = await service.upload([
      'submission-created',
      'submission-rejected',
    ]);

    expect(result.outcome, SubmissionUploadOutcome.partial);
    expect(result.unresolvedIds, isEmpty);
    final created = await db.dataInstancesDao.getById('submission-created');
    final rejected = await db.dataInstancesDao.getById('submission-rejected');
    expect(created!.syncState, InstanceSyncStatus.synced);
    expect(rejected!.syncState, InstanceSyncStatus.syncFailed);
    final failure = FailureSnapshot.tryDecode(rejected.lastSyncMessage);
    expect(failure?.errorCode, DRunErrorCode.invalidData);
    expect(
      failure?.serverFailure?.detail,
      'The submission contains invalid values',
    );
  });

  test('a fully rejected response is distinct from request failure', () async {
    await _insertSubmission(
      db,
      id: 'submission-rejected',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.responseData = {
      'created': <String>[],
      'updated': <String>[],
      'failed': {
        'submission-rejected': {
          'error_code': 'E4114',
          'message': 'User is not part of the submission team',
        },
      },
    };

    final result = await service.upload(['submission-rejected']);

    expect(result.outcome, SubmissionUploadOutcome.rejected);
    expect(result.failure, isNull);
    final rejected = await db.dataInstancesDao.getById('submission-rejected');
    final failure = FailureSnapshot.tryDecode(rejected!.lastSyncMessage);
    expect(failure?.serverFailure?.code, 'E4114');
  });

  test('omitted response rows leave uploading as typed bad responses',
      () async {
    await _insertSubmission(
      db,
      id: 'submission-omitted',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.responseData = {
      'created': <String>[],
      'updated': <String>[],
      'failed': <String, Object?>{},
    };

    final result = await service.upload(['submission-omitted']);

    expect(result.outcome, SubmissionUploadOutcome.rejected);
    expect(result.unresolvedIds, {'submission-omitted'});
    final omitted = await db.dataInstancesDao.getById('submission-omitted');
    expect(omitted!.syncState, InstanceSyncStatus.syncFailed);
    expect(
      FailureSnapshot.tryDecode(omitted.lastSyncMessage)?.errorCode,
      DRunErrorCode.badResponse,
    );
  });

  test('malformed summaries become typed request failures', () async {
    await _insertSubmission(
      db,
      id: 'submission-malformed',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.responseData = {
      'created': {'not': 'a list'},
    };

    final result = await service.upload(['submission-malformed']);

    expect(result.outcome, SubmissionUploadOutcome.requestFailure);
    expect(result.failure?.errorCode, DRunErrorCode.badResponse);
    final malformed = await db.dataInstancesDao.getById('submission-malformed');
    expect(malformed!.syncState, InstanceSyncStatus.syncFailed);
    expect(
      FailureSnapshot.tryDecode(malformed.lastSyncMessage)?.errorCode,
      DRunErrorCode.badResponse,
    );
  });

  test('non-object summaries become typed request failures', () async {
    await _insertSubmission(
      db,
      id: 'submission-malformed-body',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.responseData = const ['unexpected'];

    final result = await service.upload(['submission-malformed-body']);

    expect(result.outcome, SubmissionUploadOutcome.requestFailure);
    expect(result.failure?.errorCode, DRunErrorCode.badResponse);
    final malformed =
        await db.dataInstancesDao.getById('submission-malformed-body');
    expect(malformed!.syncState, InstanceSyncStatus.syncFailed);
    expect(
      FailureSnapshot.tryDecode(malformed.lastSyncMessage)?.errorCode,
      DRunErrorCode.badResponse,
    );
  });

  test('no eligible rows is distinct from an upload failure', () async {
    await _insertSubmission(
      db,
      id: 'draft-only',
      syncState: InstanceSyncStatus.draft,
      formData: const {},
    );

    final result = await service.upload(['draft-only']);

    expect(result.outcome, SubmissionUploadOutcome.nothingToUpload);
    expect(apiClient.resourceName, isNull);
  });

  test('legacy string-encoded summary fields remain compatible', () async {
    await _insertSubmission(
      db,
      id: 'submission-legacy-summary',
      syncState: InstanceSyncStatus.finalized,
      formData: const {},
    );
    apiClient.responseData = {
      'created': '["submission-legacy-summary"]',
      'updated': '[]',
      'failed': '{}',
    };

    final result = await service.upload(['submission-legacy-summary']);

    expect(result.outcome, SubmissionUploadOutcome.complete);
    final saved =
        await db.dataInstancesDao.getById('submission-legacy-summary');
    expect(saved!.syncState, InstanceSyncStatus.synced);
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
    final result = await upload;
    await drain;

    expect(result.outcome, SubmissionUploadOutcome.requestFailure);
    expect(result.failure?.errorCode, DRunErrorCode.sessionExpired);
    final saved = await db.dataInstancesDao.getById('submission-expired');
    expect(saved!.syncState, InstanceSyncStatus.syncFailed);
    expect(
      FailureSnapshot.tryDecode(saved.lastSyncMessage)?.errorCode,
      DRunErrorCode.sessionExpired,
    );
    expect(drainCompleted, isTrue);
  });
}

Future<void> _insertTemplate(AppDatabase db) async {
  await db.customStatement('''
    INSERT INTO form_templates
      (id, version_uid, version_number, name)
    VALUES ('form-1', 'version-1', 1, 'Upload test form');
  ''');
  await db.into(db.formTemplateVersions).insert(
        FormTemplateVersion(
          id: 'version-1',
          template: 'form-1',
          versionNumber: 1,
          fields: [
            FieldTemplate(
              id: 'text-field',
              name: 'textField',
              type: ValueType.Text,
            ),
          ],
          sections: const [],
          options: const [],
        ),
      );
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
  Object? responseData = const <String, dynamic>{};
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
