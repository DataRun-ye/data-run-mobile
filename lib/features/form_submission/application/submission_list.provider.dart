import 'package:d_sdk/core/common/geometry.dart';
import 'package:d_sdk/core/exception/d_error.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data/code_generator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/form_submission_repository.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_list.provider.g.dart';

@riverpod
FormSubmissionRepository formSubmissionRepository(Ref ref) {
  return FormSubmissionRepository();
}

@riverpod
class FormSubmissions extends _$FormSubmissions {
  Future<IList<DataInstance>> build(String form) async {
    final submissions =
        await ref.watch(formSubmissionRepositoryProvider).getSubmissions(form);
    return submissions;
  }

  AppDatabase get _db => DSdk.db;

  Future<void> markSubmissionAsFinal(String uid) async {
    await _db.managers.dataInstances.filter((f) => f.id(uid)).update(
        (o) => o.call(syncState: const Value(InstanceSyncStatus.finalized)));

    ref.invalidateSelf();
    await future;
  }

  /// injecting the arguments from the context
  Future<DataInstance> createNewSubmission(
      {required String assignmentId,
      required String team,
      required String form,
      required String formVersion,
      // required int version,
      Map<String, dynamic> formData = const {},
      Geometry? geometry}) async {
    final submission = await _db.managers.dataInstances.createReturning(
        (o) => o(
            id: CodeGenerator.generateUid(),
            formTemplate: form,
            templateVersion: formVersion,
            assignment: Value(assignmentId),
            syncState: InstanceSyncStatus.draft,
            team: Value(team),
            isToUpdate: false,
            formData: Value(formData)),
        mode: InsertMode.replace);

    ref.invalidateSelf();
    await future;
    return submission;
  }

  Future<DataInstance?> getSubmission(String uid) async {
    final finishedInitState = (await future);
    return finishedInitState.firstOrNullWhere((s) => s.id == uid);
  }

  Future<DataInstance> updateSubmission(DataInstance submission) async {
    DataInstance toUpdate = submission.copyWith();
    if (submission.syncState.isSynced) {
      toUpdate = submission.copyWith(isToUpdate: true);
    } else {
      toUpdate = submission.copyWith(syncState: InstanceSyncStatus.draft);
    }
    await _db.update(_db.dataInstances).replace(toUpdate);
    ref.invalidateSelf();
    await future;

    return toUpdate;
  }

  Future<bool> deleteSubmission(Iterable<String> syncableIds) async {
    try {
      await (_db.delete(_db.dataInstances)
            ..where((tbl) => tbl.id.isIn(syncableIds)))
          .go();

      ref.invalidateSelf();
      await future;
      return true;
    } on DError catch (e) {
      logError('# DataRun Error: ${e.toString()}');
      return false;
    }
  }

  Future<void> syncEntities(List<String> uids) async {
    await DSdk.db.dataInstancesDao.upload(uids);
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<bool> submissionEditStatus(Ref ref,
    {required FormMetadata formMetadata}) async {
  final db = DSdk.db;
  final assignmentForm = await db.managers.assignmentForms
      .filter((f) =>
          f.assignment.id(formMetadata.assignmentModel.id) &
          f.form.id(formMetadata.formId))
      .getSingleOrNull();
  if (assignmentForm == null) return false;
  return assignmentForm.canAddSubmissions == true ||
      assignmentForm.canEditSubmissions == true;
}
