import 'package:collection/collection.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_model.provider.g.dart';

@riverpod
Future<List<AssignmentModel>> assignments(
  Ref ref,
  String activityId,
) async {
  final List<AssignmentModel> assignments =
      await DSdk.db.assignmentsDao.allAssignments(activityId: activityId);

  final List<Pair<AssignmentForm, bool>> userForms =
      await ref.watch(userAvailableFormsProvider().future);

  return assignments.map((assignment) {
    final List<Pair<AssignmentForm, bool>> assignmentForms = userForms
        .where((uf) => uf.first.assignment == assignment.id)
        .sorted((a, b) => a.first.form.compareTo(b.first.form))
        .toList();
    return assignment.copyWith(userForms: assignmentForms);
  }).toList();
}
