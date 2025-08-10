import 'package:collection/collection.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data/data.dart';
import 'package:datarunmobile/features/activity/application/activity.provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_model.provider.g.dart';

@riverpod
Future<List<FormTemplateVersion>> assignmentForms(Ref ref) {
  throw UnimplementedError();
}

@riverpod
AssignmentModel assignment(Ref ref) {
  throw UnimplementedError();
}

/// a notifier that retrieves all assignments with their data populated
@Riverpod(dependencies: [activityModel])
class Assignments extends _$Assignments {
  @override
  Future<List<AssignmentModel>> build() async {
    final db = DSdk.db;
    final activityModel = ref.watch(activityModelProvider);

    final List<AssignmentModel> assignments =
        await db.assignmentsDao.allAssignments(activityId: activityModel.id);

    final List<Pair<AssignmentForm, bool>> userForms =
        await ref.watch(userAvailableFormsProvider().future);

    final assignmentModels = assignments.map((assignment) {
      final List<Pair<AssignmentForm, bool>> assignmentForms = userForms
          .where((uf) => uf.first.assignment == assignment.id)
          .sorted((a, b) => a.first.form.compareTo(b.first.form))
          .toList();
      return assignment.copyWith(userForms: assignmentForms);
    }).toList();
    return assignmentModels;
  }

  //
  void updateAssignmentStatus(
      AssignmentStatus? progressStatus, String assignmentId) async {
    await DSdk.db.managers.assignments
        .filter((f) => f.id(assignmentId))
        .update((o) => o.call(
              status: Value.absentIfNull(progressStatus),
            ));

    ref.invalidateSelf();
    await future;
  }
}
