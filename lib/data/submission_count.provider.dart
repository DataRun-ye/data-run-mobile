import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/assignment/assignment_model.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/data/submission_list.provider.dart';
import 'package:datarunmobile/data_run/form/form_submission/submission_list_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_count.provider.g.dart';

@Riverpod(dependencies: [assignment])
Future<int> submissionsSyncStateCount(
    SubmissionsSyncStateCountRef ref, SyncStatus syncStatus) async {
  final AssignmentModel assignment = ref.watch(assignmentProvider);
  double count = 0.0;
  for (var form in assignment.userForms) {
    final formSubmissions = await ref.watch(formSubmissionsProvider(form.first.form)
        .selectAsync((submissions) => submissions
            .where((s) =>
                SubmissionListUtil.getSyncStatus(s) == syncStatus &&
                s.assignment == assignment.id)
            .length));

    count = count + formSubmissions;
  }

  return count.toInt();
}
