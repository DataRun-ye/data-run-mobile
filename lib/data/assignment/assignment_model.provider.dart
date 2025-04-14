import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/commons/extensions/list_extensions.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/assignment/assignment.provider.dart';
import 'package:datarunmobile/data/team/teams.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/data_run/d_assignment/model/extract_and_sum_allocated_actual.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assignment_model.provider.g.dart';

@riverpod
Future<List<FormVersion>> assignmentForms(AssignmentFormsRef ref) {
  throw UnimplementedError();
}

@riverpod
AssignmentModel assignment(AssignmentRef ref) {
  throw UnimplementedError();
}

/// a notifier that retrieves all assignments with their data populated
@Riverpod(dependencies: [activityModel])
class Assignments extends _$Assignments {
  @override
  Future<List<AssignmentModel>> build() async {
    final activityModel = ref.watch(activityModelProvider);
    // final query = D2Remote.assignmentModuleD.assignment;
    //
    // if (activityModel.activity != null) {
    //   query.where(attribute: 'activity', value: activityModel.activity!.id);
    // }

    final List<Assignment> assignments = await (activityModel.activity != null
        ? DSdk.db.managers.assignments
            .filter((f) => f.activity.id(activityModel.activity!.id))
            .get()
        : DSdk.db.managers.assignments.get());
    // await query.get();

    final futures =
        assignments.map<Future<AssignmentModel>>((assignment) async {
      final activityEntity = await DSdk.db.managers.activities
          .filter((f) => f.id(assignment.activity))
          .getSingleOrNull();
      // await D2Remote.activityModuleD.activity
      //     .byId(assignment.activity!)
      //     .getOne();
      final orgUnitEntity = await DSdk.db.managers.orgUnits
          .filter((f) => f.id(assignment.orgUnit))
          .getSingleOrNull();
      // await D2Remote.organisationUnitModuleD.orgUnit
      //     .byId(assignment.orgUnit!)
      //     .getOne();

      final teamEntity = await DSdk.db.managers.teams
          .filter((f) => f.id(assignment.team))
          .getSingleOrNull();
      // await D2Remote.teamModuleD.team.byId(assignment.team!).getOne();

      final IList<TeamModel> assignedTeams =
          await ref.watch(teamsProvider(EntityScope.Assigned).future);

      final IList<TeamModel> managedTeams =
          await ref.watch(teamsProvider(EntityScope.Managed).future);

      final assignedForms = assignedTeams
          .expand((t) => t.formPermissions)
          .map((f) => f.form)
          .toList();

      final assignmentForms =
          assignment.forms.where((f) => assignedForms.contains(f)).toList();
      List<DataSubmission> submissions = [];

      for (var form in assignmentForms) {
        submissions.addAll(await ref.watch(
            assignmentSubmissionsProvider(assignment.id!, form: form).future));
      }

      AssignmentStatus status;

      // if (submissions.isEmpty) {
      //   status = AssignmentStatus.NOT_STARTED;
      // } else {
      //   final sortedSubmissions = submissions.toList()
      //     ..sort((a, b) => b.lastModifiedDate!.compareTo(a.lastModifiedDate!));
      //   status = sortedSubmissions.first.status!;
      status = assignment.status ?? AssignmentStatus.NOT_STARTED;
      // }

      final resourceHeaders = assignments
              .maxBy((item) => item.allocatedResources.length)
              ?.allocatedResources
              .keys
              .where((t) => t != 'Latitude' && t != 'Longitude')
              .toList() ??
          [];

      return AssignmentModel(
        id: assignment.id!,
        activityId: activityEntity!.id!,
        activity: activityEntity.name!,
        entityId: orgUnitEntity!.id!,
        entityCode: orgUnitEntity.code!,
        entityName: orgUnitEntity.name!,
        teamId: teamEntity!.id!,
        teamCode: teamEntity.code!,
        teamName: teamEntity.name!,
        scope: assignment.scope ?? EntityScope.Assigned,
        status: status,
        dueDate: activityEntity.startDate != null
            ? AssignmentModel.calculateAssignmentDate(
                activityEntity.startDate, assignment.startDay)
            : null,
        startDay: assignment.startDay,
        rescheduledDate: assignment.startDate?.toLocal(),
        allocatedResources: managedTeams.length > 0
            ? resourceHeaders
                .asMap()
                .map((k, v) => MapEntry(v, assignment.allocatedResources[v]))
            : {for (var i in resourceHeaders) i: 0},
        reportedResources: sumActualResources(submissions, resourceHeaders),
        forms: assignment.forms,
      );
    }).toList();

    final assignmentModels = await Future.wait<AssignmentModel>(futures);
    return assignmentModels;
  }

  void updateAssignmentStatus(
      AssignmentStatus? status, String assignmentId) async {
    // final previousState = await future;

    Assignment? assignment = await DSdk.db.managers.assignments
        .filter((f) => f.id(assignmentId))
        .getSingleOrNull();
    // await D2Remote.assignmentModuleD.assignment.byId(assignmentId).getOne();
    if (assignment != null) {
      Assignment toUpdate = assignment.copyWith(status: Value(status));
      // DataSubmission.fromJson({
      //   ...assignment.toJson(),
      //   'status': status,
      //   'lastModifiedDate': DateHelper.nowUtc()
      // });

      await DSdk.db.assignmentsDao
          .updateItem(assignment.copyWith(status: Value(status)));
      // await D2Remote.assignmentModuleD.assignment
      //     .setData(toUpdate)
      //     .save(saveOptions: SaveOptions(skipLocalSyncStatus: false));
    }

    ref.invalidateSelf();
    await future;
  }
}
