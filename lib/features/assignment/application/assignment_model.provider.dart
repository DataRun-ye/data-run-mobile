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

  return withUserForms(assignments, userForms);
}

/// Gives each assignment its forms from [userForms], sorted by form.
///
/// The forms are grouped by assignment in one pass. Matching every
/// assignment against every form of the user ran on the UI thread, which
/// Android shares with Flutter: users with thousands of assignments froze
/// for seconds and got "app not responding".
List<AssignmentModel> withUserForms(
  List<AssignmentModel> assignments,
  List<AssignmentFormAvailability> userForms,
) {
  final formsByAssignment =
      groupBy(userForms, (uf) => uf.assignmentForm.assignment);
  return assignments.map((assignment) {
    final List<Pair<AssignmentForm, bool>> assignmentForms =
        (formsByAssignment[assignment.id] ?? const [])
            .map((uf) => Pair(uf.assignmentForm, uf.isAvailableLocally))
            .sorted((a, b) => a.first.form.compareTo(b.first.form))
            .toList();
    return assignment.copyWith(userForms: assignmentForms);
  }).toList();
}
