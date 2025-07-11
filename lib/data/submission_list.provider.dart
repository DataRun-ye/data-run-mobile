import 'package:d_sdk/core/common/geometry.dart';
import 'package:d_sdk/core/exception/d_error.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/data/code_generator.dart';
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

  AppDatabase get db => DSdk.db;

  Future<void> markSubmissionAsFinal(String uid) async {
    await db.managers.dataInstances.filter((f) => f.id(uid)).update(
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
    final submission = await db.managers.dataInstances.createReturning(
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
    await db.update(db.dataInstances).replace(toUpdate);
    ref.invalidateSelf();
    await future;

    return toUpdate;
  }

  Future<bool> deleteSubmission(Iterable<String> syncableIds) async {
    try {
      await (db.delete(db.dataInstances)
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
    // await (D2Remote.formSubmissionModule.formSubmission.byIds(uids)
    //         as SyncableQuery)
    //     .upload();

    await DSdk.dataInstanceSource.upload(uids);

    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<bool> submissionEditStatus(Ref ref,
    {required FormMetadata formMetadata}) async {
  final db = DSdk.db;
  final teamsWithRefs = await db.managers.teams
      .filter((f) => f.id(formMetadata.assignmentModel.team.id))
      .withReferences((prefetch) => prefetch(teamFormPermissions: true))
      .getSingleOrNull();
  if (teamsWithRefs == null) {
    return false;
  }

  final (todo, refs) = teamsWithRefs;

  final formPermission = refs.teamFormPermissions.prefetchedData
      ?.where((t) => t.form == formMetadata.formId)
      .firstOrNull;
  return formPermission?.permissions.canEdit ?? false;
}
//
// @riverpod
// Future<IMap<String, dynamic>> formSubmissionData(FormSubmissionDataRef ref,
//     {required String submissionId}) async {
//   final DataInstance? formSubmission = await ref
//       .watch(formSubmissionRepositoryProvider)
//       .getSubmission(submissionId);
//   final submissionData = await ref.watch(
//       formSubmissionsProvider(formSubmission!.formTemplate).selectAsync(
//           (IList<DataInstance> submissions) => submissions
//               .firstWhere((item) => item.id == submissionId)
//               .formData));
//   return IMap.withConfig(submissionData, const ConfigMap(cacheHashCode: false));
// }
//
// @riverpod
// Future<List<DataInstance>> submissionFilteredByState(
//     SubmissionFilteredByStateRef ref,
//     {required String form,
//     SyncStatus? status,
//     String sortBy = 'name'}) async {
//   final allSubmissions = await ref.watch(formSubmissionsProvider(form).future);
//
//   final filteredSubmission = allSubmissions
//       .where(SubmissionListUtil.getFilterPredicate(status))
//       .toList();
//
//   filteredSubmission.sort((a, b) =>
//       (b.finishedEntryTime ?? b.startEntryTime ?? b.name ?? '')
//           .compareTo(a.finishedEntryTime ?? a.startEntryTime ?? a.name ?? ''));
//   return filteredSubmission;
// }
//
// @riverpod
// Future<SubmissionItemSummaryModel> submissionInfo(SubmissionInfoRef ref,
//     {required FormMetadata formMetadata}) async {
//   final allSubmissions =
//       await ref.watch(formSubmissionsProvider(formMetadata.formId).future);
//
//   final submission =
//       allSubmissions.firstWhere((t) => t.id == formMetadata.submission!);
//
//   final Assignment? assignment = submission.assignment != null
//       ? await D2Remote.assignmentModuleD.assignment
//           .byId(submission.assignment!)
//           .getOne()
//       : null;
//
//   final OrgUnit? orgUnit = assignment != null
//       ? await D2Remote.organisationUnitModuleD.orgUnit
//           .byId(assignment.orgUnit!)
//           .getOne()
//       : null;
//
//   // final extract = extractValues(
//   //     submission.formData, formConfig.allFields.unlockView.values.toList(),
//   //     criteria: (Template t) => t.mainField == true);
//   // final formData = extract.map((k, v) => MapEntry(
//   //     formConfig.getFieldDisplayName(k),
//   //     formConfig.getUserFriendlyValue(k, v)));
//
//   return SubmissionItemSummaryModel(
//       syncStatus: SubmissionListUtil.getSyncStatus(submission)!,
//       code: orgUnit?.code,
//       orgUnit: '${orgUnit?.displayName ?? getItemLocalString(orgUnit?.label)}',
//       formData: submission.formData);
// }
