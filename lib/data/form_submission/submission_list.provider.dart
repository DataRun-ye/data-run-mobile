import 'package:d_sdk/core/common/geometry.entity.dart';
import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data_run/form/form_submission/form_submission_repository.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:datarunmobile/data_run/screens/form_module/form/code_generator.dart';
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
  Future<IList<DataSubmission>> build(String form) async {
    final submissions =
        await ref.watch(formSubmissionRepositoryProvider).getSubmissions(form);
    return submissions;
  }

  AppDatabase get db => DSdk.db;

  Future<void> markSubmissionAsFinal(String uid) async {
    await db.managers.dataSubmissions.filter((f) => f.id(uid)).update(
        (o) => o.call(syncState: const Value(InstanceSyncStatus.finalized)));

    ref.invalidateSelf();
    await future;
  }

  /// injecting the arguments from the context
  Future<DataSubmission> createNewSubmission(
      {required String assignmentId,
      required String team,
      required String form,
      required String formVersion,
      required int version,
      Map<String, dynamic> formData = const {},
      Geometry? geometry}) async {
    final submission = await db.managers.dataSubmissions.createReturning(
        (o) => o(
            id: CodeGenerator.generateUid(),
            dataTemplate: form,
            dataTemplateVer: formVersion,
            assignmentType: assignmentId,
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

  Future<DataSubmission?> getSubmission(String uid) async {
    final finishedInitState = (await future);
    return finishedInitState.firstOrNullWhere((s) => s.id == uid);
  }

  Future<void> updateSubmission(DataSubmission submission) async {
    await db
        .update(db.dataSubmissions)
        .replace(submission.copyWith(syncState: InstanceSyncStatus.draft));
    ref.invalidateSelf();
    await future;
  }

  Future<bool> deleteSubmission(Iterable<String> syncableIds) async {
    try {
      await (db.delete(db.dataSubmissions)
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

    await DSdk.dataSubmissionDataSource.upload(uids);

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

@riverpod
Future<IMap<String, dynamic>> formSubmissionData(Ref ref,
    {required String submissionId}) async {
  final DataSubmission? formSubmission = await ref
      .watch(formSubmissionRepositoryProvider)
      .getSubmission(submissionId);
  final submissionData = await ref.watch(
      formSubmissionsProvider(formSubmission!.dataTemplate).selectAsync(
          (IList<DataSubmission> submissions) => submissions
              .firstWhere((item) => item.id == submissionId)
              .formData));
  return IMap.withConfig(submissionData, const ConfigMap(cacheHashCode: false));
}
//
// @riverpod
// Future<List<DataSubmission>> submissionFilteredByState(
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
