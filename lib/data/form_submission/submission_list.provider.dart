import 'package:d_sdk/core/common/dhis_uid_generator.util.dart';
import 'package:d_sdk/core/common/geometry.entity.dart';
import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/form/form_permission.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/extensions/list_extensions.dart';
import 'package:datarunmobile/data_run/form/form_submission/form_submission_repository.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:drift/src/runtime/data_class.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_list.provider.g.dart';

@riverpod
FormSubmissionRepository formSubmissionRepository(
    Ref ref) {
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
    final DataSubmission? submission = await (db.select(db.dataSubmissions)
          ..where((tbl) => tbl.id.equals(uid)))
        .getSingleOrNull();

    await db.update(db.dataSubmissions).replace(submission!.copyWith(
        status: const Value(SubmissionStatus.synced),
        lastModifiedDate: DateTime.now().toUtc(),
        finishedEntryTime: Value(DateTime.now().toUtc())));

    ref.invalidateSelf();
    await future;
  }

  /// injecting the arguments from the context
  Future<DataSubmission> createNewSubmission(
      {required formVersion,
      required String assignmentId,
      required String team,
      required String form,
      required int version,
      Map<String, dynamic> formData = const {},
      Geometry? geometry}) async {
    final id = DhisUidGenerator.generate();
    final DataSubmission submission = DataSubmission(
        id: id,
        deleted: false,
        status: SubmissionStatus.draft,
        progressStatus: AssignmentStatus.IN_PROGRESS,
        assignment: assignmentId,
        form: form,
        team: team,
        formVersion: formVersion,
        version: version,
        formData: formData,
        lastModifiedDate: DateTime.now().toUtc(),
        createdDate: DateTime.now().toUtc(),
        startEntryTime: DateTime.now().toUtc());

    await db.into(db.dataSubmissions).insert(submission);

    ref.invalidateSelf();
    await future;
    return submission;
  }

  Future<DataSubmission?> getSubmission(String uid) async {
    final finishedInitState = (await future);
    return finishedInitState.firstOrNullWhere((s) => s.id == uid);
  }

  Future<void> updateSubmission(DataSubmission submission) async {
    await db.update(db.dataSubmissions).replace(submission.copyWith(
        status: Value(SubmissionStatus.draft),
        lastModifiedDate: DateTime.now().toUtc()));
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

    await  DSdk.dataSubmissionDataSource.upload(uids);

    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<bool> submissionEditStatus(Ref ref,
    {required FormMetadata formMetadata}) async {
  final db = DSdk.db;
  final submission = await (db.select(db.dataSubmissions)
        ..where((tbl) => tbl.id.equals(formMetadata.submission!)))
      .getSingleOrNull();
  final team = await (db.select(db.teams)
        ..where((tbl) => tbl.id.equals(formMetadata.assignmentModel.teamId)))
      .getSingleOrNull();
  final List<FormPermission> formPermissions = team?.formPermissions
          ?.where((t) => t.form == formMetadata.formId)
          .expand((t) => t.permissions)
          .toSet()
          .toList() ??
      [];
  // TeamFormPermission.canApprove();

  return submission?.status?.isToSync() == true ||
      formPermissions
          .any((t) => FormPermission.approvingPermissions.contains(t));
}

@riverpod
Future<IMap<String, dynamic>> formSubmissionData(Ref ref,
    {required String submissionId}) async {
  final DataSubmission? formSubmission = await ref
      .watch(formSubmissionRepositoryProvider)
      .getSubmission(submissionId);
  final submissionData = await ref.watch(
      formSubmissionsProvider(formSubmission!.form).selectAsync(
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
