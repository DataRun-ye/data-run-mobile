import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/collections.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data/data.dart';
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
    final List<String> assignmentIds = assignments.map((a) => a.id).toList();

    // final List<AssignmentForm> userForms = await db.managers.assignmentForms
    //     .filter((f) => f.assignment.id.isIn(assignmentIds))
    //     .get();
    final List<Pair<AssignmentForm, bool>> userForms =
        await ref.watch(userAvailableFormsProvider().future);

    final assignmentModels = assignments.map((assignment) {
      final assignmentForms = userForms
          .where((uf) => uf.first.assignment == assignment.id)
          .toList();
      return assignment.copyWith(
        userForms: assignmentForms);
    }).toList();
    // final futures =
    //     assignments.map<Future<AssignmentModel>>((assignment) async {
    //   return AssignmentModel(
    //     id: assignment.id!,
    //     activityId: assignment.activity,
    //     entityId: assignment.orgUnit,
    //     entityCode: assignment.orgUnitCode ?? '',
    //     entityName: assignment.orgUnitName ?? '',
    //     teamId: assignment.team,
    //     teamCode: assignment.teamCode ?? '',
    //     teamName: assignment.teamCode ?? '',
    //     scope: assignment.scope ?? EntityScope.Assigned,
    //     status: assignment.status ?? AssignmentStatus.NOT_STARTED,
    //     startDay: assignment.startDay,
    //     rescheduledDate: assignment.startDate != null
    //         ? DateTime.parse(
    //             DateHelper.fromDbUtcToUiLocalFormat(assignment.startDate!))
    //         : null,
    //     userForms: userForms
    //         .where((uf) =>
    //             assignment.forms.contains(uf.first.form) &&
    //             uf.first.team == assignment.team)
    //         .toList(),
    //   );
    // }).toList();
    //
    // final assignmentModels = await Future.wait<AssignmentModel>(futures);
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
