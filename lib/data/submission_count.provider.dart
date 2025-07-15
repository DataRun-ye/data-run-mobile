import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:datarunmobile/features/assignment/application/assignment_model.provider.dart';
import 'package:datarunmobile/data/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list_util.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submission_count.provider.g.dart';

@Riverpod(dependencies: [assignment])
Future<int> submissionsSyncStateCount(
    Ref ref, InstanceSyncStatus syncStatus) async {
  final AssignmentModel assignment = ref.watch(assignmentProvider);
  double count = 0.0;
  for (var form in assignment.userForms) {
    final c = await DSdk.db.managers.dataInstances
        .filter((f) => f.syncState(syncStatus) & f.assignment.id(assignment.id))
        .count();
    final formSubmissions = await ref.watch(
        formSubmissionsProvider(form.first.form).selectAsync((submissions) =>
            submissions
                .where((s) =>
                    SubmissionListUtil.getSyncStatus(s) == syncStatus &&
                    s.assignment == assignment.id)
                .length));

    count = count + c;
  }

  return count.toInt();
}
