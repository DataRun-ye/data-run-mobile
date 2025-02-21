import 'package:datarun/core/common/state.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:datarun/data_run/form/form_submission/submission_list_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_count_provider.g.dart';

@Riverpod(dependencies: [assignment])
Future<int> submissionsSyncStateCount(
    SubmissionsSyncStateCountRef ref, SyncStatus syncStatus) async {
  final AssignmentModel assignment = ref.watch(assignmentProvider);
  double count = 0.0;
  for (var form in assignment.forms) {
    final formSubmissions = await ref.watch(formSubmissionsProvider(form)
        .selectAsync((submissions) => submissions
        .where((s) =>
    SubmissionListUtil.getSyncStatus(s) == syncStatus && s.assignment == assignment.id)
        .length));

    count = count + formSubmissions;
  }

  return count.toInt();
}
