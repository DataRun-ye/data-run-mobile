import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_model.provider.g.dart';

// @riverpod
// Future<List<FormVersion>> assignmentForms(Ref ref) {
//   throw UnimplementedError();
// }

@riverpod
AssignmentModel assignment(Ref ref) {
  throw UnimplementedError();
}

/// a notifier that retrieves all assignments with their data populated
@Riverpod(dependencies: [activityModel])
class AssignmentModels extends _$AssignmentModels {
  @override
  Future<List<AssignmentModel>> build() async {
    final activityModel = ref.watch(activityModelProvider);
    final query = DSdk.db.assignmentsDao
        .watchAssignmentCardsForActivity(activityId:
    activityModel.activity.id);

    final List<AssignmentModel> assignments = await query.get();
    final assignmentModels = assignments.map<AssignmentModel>((assignment) {
      // final assignedForms = appLocator<User>().userFormsUIDs;

      // final assignmentForms =
      //     assignment.forms.where((f) => assignedForms.contains(f)).toList();

      return assignment;
    }).toList();

    return assignmentModels;
  }

  void updateAssignmentStatus(
      AssignmentStatus? progressStatus, String assignmentId) async {
    await DSdk.db.managers.assignments.filter((f) => f.id(assignmentId)).update(
        (o) => o.call(progressStatus: Value.absentIfNull(progressStatus)));

    ref.invalidateSelf();
    await future;
  }
}
