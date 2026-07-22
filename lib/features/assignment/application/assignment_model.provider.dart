import 'package:collection/collection.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/assignment_model.dart';
import 'package:datarunmobile/database/shared/collections.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_model.provider.g.dart';

@riverpod
Future<List<AssignmentModel>> assignments(
  Ref ref,
  String activityId,
) async {
  final List<AssignmentModel> assignments = await appLocator<AppDatabase>()
      .assignmentsDao
      .allAssignments(activityId: activityId);

  final List<AssignmentFormAvailability> userForms =
      await ref.watch(userAvailableFormsProvider().future);

  return assignments.map((assignment) {
    final List<Pair<AssignmentForm, bool>> assignmentForms = userForms
        .where((uf) => uf.assignmentForm.assignment == assignment.id)
        .map((uf) => Pair(uf.assignmentForm, uf.isAvailableLocally))
        .sorted((a, b) => a.first.form.compareTo(b.first.form))
        .toList();
    return assignment.copyWith(userForms: assignmentForms);
  }).toList();
}
