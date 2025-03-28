import 'package:d2_remote/core/datarun/exception/d_error.dart';
import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/core/utilities/list_extensions.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/models/geometry.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:d2_remote/shared/utilities/dhis_uid_generator.util.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:d2_remote/core/datarun/logging/new_app_logging.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/core/utils/get_item_local_string.dart';
import 'package:datarunmobile/data_run/form/form_submission/form_submission_repository.dart';
import 'package:datarunmobile/data_run/form/form_submission/submission_list_util.dart';
import 'package:datarunmobile/data_run/form/form_submission/submission_summary.model.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_list.provider.g.dart';

@riverpod
FormSubmissionRepository formSubmissionRepository(
    FormSubmissionRepositoryRef ref) {
  return FormSubmissionRepository();
}

@riverpod
class FormSubmissions extends _$FormSubmissions {
  Future<IList<DataFormSubmission>> build(String form) async {
    final submissions =
        await ref.watch(formSubmissionRepositoryProvider).getSubmissions(form);
    return submissions;
  }

  Future<void> markSubmissionAsFinal(String uid) async {
    final String? completedDate = DateHelper.nowUtc();
    final DataFormSubmission? submission =
        await D2Remote.formSubmissionModule.formSubmission.byId(uid).getOne();

    DataFormSubmission toMark = DataFormSubmission.fromJson({
      ...submission!.toJson(),
      'isFinal': true,
      'synced': submission.synced,
      'dirty': true,
      'lastModifiedDate': DateHelper.nowUtc(),
      'finishedEntryTime': completedDate
    });

    // submission!
    //   ..isFinal = true
    //   ..synced = false
    //   ..dirty = true
    //   ..lastModifiedDate = DateHelper.nowUtc()
    //   ..finishedEntryTime = completedDate;

    await D2Remote.formSubmissionModule.formSubmission
        .setData(toMark)
        .save(saveOptions: SaveOptions(skipLocalSyncStatus: true));

    ref.invalidateSelf();
    await future;
  }

  Future<DataFormSubmission> saveOrgUnit(String uid, String? orgUnit) async {
    await future;

    final DataFormSubmission? submission =
        await D2Remote.formSubmissionModule.formSubmission.byId(uid).getOne();

    return updateSubmission(submission!..assignment = orgUnit);
  }

  /// injecting the arguments from the context
  Future<DataFormSubmission> createNewSubmission(
      {required formVersion,
      required String assignmentId,
      required String team,
      required String form,
      required int version,
      Map<String, dynamic> formData = const {},
      Geometry? geometry}) async {
    final id = DhisUidGenerator.generate();
    final DataFormSubmission submission = DataFormSubmission(
        id: id,
        status: AssignmentStatus.IN_PROGRESS,
        form: form,
        formVersion: formVersion,
        version: version,
        // activity: activityUid,
        team: team,
        assignment: assignmentId,
        formData: formData,
        dirty: true,
        synced: false,
        deleted: false,
        isFinal: false,
        lastModifiedDate: DateHelper.nowUtc(),
        startEntryTime: DateHelper.nowUtc());

    if (geometry != null) {
      submission.geometry = geometry;
    }

    await D2Remote.formSubmissionModule.formSubmission
        .setData(submission)
        .save(saveOptions: SaveOptions(skipLocalSyncStatus: false));

    final savedSubmission = await D2Remote.formSubmissionModule.formSubmission
        .byId(submission.id!)
        .getOne();
    ref.invalidateSelf();
    await future;
    return savedSubmission;
  }

  Future<DataFormSubmission?> getSubmission(String uid) async {
    final finishedInitState = (await future);
    return finishedInitState.firstOrNullWhere((s) => s.id == uid);
  }

  Future<DataFormSubmission> updateSubmission(
      DataFormSubmission submission) async {
    DataFormSubmission toUpdate = DataFormSubmission.fromJson({
      ...submission.toJson(),
      'dirty': true,
      'synced': submission.synced,
      'lastModifiedDate': DateHelper.nowUtc()
    });

    // submission.dirty = true;
    // submission.synced = false;
    // submission.lastModifiedDate = DateHelper.nowUtc();

    await D2Remote.formSubmissionModule.formSubmission
        .setData(toUpdate)
        .save(saveOptions: SaveOptions(skipLocalSyncStatus: true));

    final savedSubmission = await D2Remote.formSubmissionModule.formSubmission
        .byId(toUpdate.id!)
        .getOne();

    ref.invalidateSelf();
    await future;
    return savedSubmission;
  }

  Future<bool> deleteSubmission(Iterable<String?> syncableIds) async {
    try {
      await Future.forEach(
          syncableIds,
          (uid) =>
              D2Remote.formSubmissionModule.formSubmission.byId(uid!).delete());

      ref.invalidateSelf();
      await future;
      return true;
    } on DError catch (e) {
      logError('# DataRun Error: ${e.toString()}');
      return false;
    }
  }

  Future<void> syncEntities(List<String> uids) async {
    await D2Remote.formSubmissionModule.formSubmission.byIds(uids).upload();

    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<bool> submissionEditStatus(SubmissionEditStatusRef ref,
    {required FormMetadata formMetadata}) async {
  return D2Remote.formSubmissionModule.formSubmission
      .byId(formMetadata.submission!)
      .canEdit();
}

@riverpod
Future<IMap<String, dynamic>> formSubmissionData(FormSubmissionDataRef ref,
    {required String submissionId}) async {
  final DataFormSubmission? formSubmission = await ref
      .watch(formSubmissionRepositoryProvider)
      .getSubmission(submissionId);
  final submissionData = await ref.watch(
      formSubmissionsProvider(formSubmission!.form!).selectAsync(
          (IList<DataFormSubmission> submissions) => submissions
              .firstWhere((item) => item.id == submissionId)
              .formData));
  return IMap.withConfig(submissionData, const ConfigMap(cacheHashCode: false));
}

@riverpod
Future<List<DataFormSubmission>> submissionFilteredByState(
    SubmissionFilteredByStateRef ref,
    {required String form,
    SyncStatus? status,
    String sortBy = 'name'}) async {
  final allSubmissions = await ref.watch(formSubmissionsProvider(form).future);

  final filteredSubmission = allSubmissions
      .where(SubmissionListUtil.getFilterPredicate(status))
      .toList();

  filteredSubmission.sort((a, b) =>
      (b.finishedEntryTime ?? b.startEntryTime ?? b.name ?? '')
          .compareTo(a.finishedEntryTime ?? a.startEntryTime ?? a.name ?? ''));
  return filteredSubmission;
}

@riverpod
Future<SubmissionItemSummaryModel> submissionInfo(SubmissionInfoRef ref,
    {required FormMetadata formMetadata}) async {
  final allSubmissions =
      await ref.watch(formSubmissionsProvider(formMetadata.formId).future);

  final submission =
      allSubmissions.firstWhere((t) => t.id == formMetadata.submission!);

  final Assignment? assignment = submission.assignment != null
      ? await D2Remote.assignmentModuleD.assignment
          .byId(submission.assignment!)
          .getOne()
      : null;

  final OrgUnit? orgUnit = assignment != null
      ? await D2Remote.organisationUnitModuleD.orgUnit
          .byId(assignment.orgUnit!)
          .getOne()
      : null;

  // final extract = extractValues(
  //     submission.formData, formConfig.allFields.unlockView.values.toList(),
  //     criteria: (Template t) => t.mainField == true);
  // final formData = extract.map((k, v) => MapEntry(
  //     formConfig.getFieldDisplayName(k),
  //     formConfig.getUserFriendlyValue(k, v)));

  return SubmissionItemSummaryModel(
      syncStatus: SubmissionListUtil.getSyncStatus(submission)!,
      code: orgUnit?.code,
      orgUnit: '${orgUnit?.displayName ?? getItemLocalString(orgUnit?.label)}',
      formData: submission.formData);
}
