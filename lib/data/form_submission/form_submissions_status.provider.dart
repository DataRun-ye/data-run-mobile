import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/form_submission/submission_list.provider.dart';
import 'package:datarunmobile/data_run/form/form_submission/submission_list_util.dart';
import 'package:datarunmobile/data_run/screens/project_activity_detail/form_tiles/form_submissions_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_submissions_status.provider.g.dart';

@riverpod
Future<FormSubmissionsStatus> formSubmissionsStatus(
    FormSubmissionsStatusRef ref, String form) async {
  final allSubmissions =
      await ref.watch(formSubmissionsProvider(form.split('_').first).future);

  final toPost = allSubmissions
      .where(SubmissionListUtil.getFilterPredicate(SyncStatus.TO_POST));
  final toUpdate = allSubmissions
      .where(SubmissionListUtil.getFilterPredicate(SyncStatus.TO_UPDATE));
  final synced = allSubmissions
      .where(SubmissionListUtil.getFilterPredicate(SyncStatus.SYNCED));
  final withError = allSubmissions
      .where(SubmissionListUtil.getFilterPredicate(SyncStatus.ERROR));

  return FormSubmissionsStatus(
      toPost: toPost.length,
      toUpdate: toUpdate.length,
      synced: synced.length,
      withError: withError.length);
}
