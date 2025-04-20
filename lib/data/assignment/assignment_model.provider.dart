import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/activity/assignment.provider.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
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
    final query = D2Remote.assignmentModuleD.assignment;
    if (activityModel.activity != null) {
      query.where(attribute: 'activity', value: activityModel.activity!.id);
    }

    final List<Assignment> assignments = await query.get();
    final IList<TeamModel> assignedTeams =
        await ref.watch(teamsProvider(EntityScope.Assigned).future);
    // final activityEntity = await D2Remote.activityModuleD.activity
    //     .byId(assignment.activity!)
    //     .getOne();
    final futures =
        assignments.map<Future<AssignmentModel>>((assignment) async {
      // final orgUnitEntity = await D2Remote.organisationUnitModuleD.orgUnit
      //     .byId(assignment.orgUnit!)
      //     .getOne();

      // final teamEntity =
      //     await D2Remote.teamModuleD.team.byId(assignment.team!).getOne();

      // final IList<TeamModel> managedTeams =
      //     await ref.watch(teamsProvider(EntityScope.Managed).future);

      final assignedForms = assignedTeams
          .expand((t) => t.formPermissions)
          .map((f) => f.form)
          .toList();

      final assignmentForms =
          assignment.forms.where((f) => assignedForms.contains(f)).toList();
      List<DataFormSubmission> submissions = [];

      for (var form in assignmentForms) {
        submissions.addAll(await ref.watch(
            assignmentSubmissionsProvider(assignment.id!, form: form).future));
      }

      // AssignmentStatus status;

      // if (submissions.isEmpty) {
      //   status = AssignmentStatus.NOT_STARTED;
      // } else {
      //   final sortedSubmissions = submissions.toList()
      //     ..sort((a, b) => b.lastModifiedDate!.compareTo(a.lastModifiedDate!));
      //   status = sortedSubmissions.first.status!;
      // status = assignment.status ?? AssignmentStatus.NOT_STARTED;
      // }

      // final resourceHeaders = assignments
      //         .maxBy((item) => item.allocatedResources.length)
      //         ?.allocatedResources
      //         .keys
      //         .where((t) => t != 'Latitude' && t != 'Longitude')
      //         .toList() ??
      //     [];

      return AssignmentModel(
        id: assignment.id!,
        activityId: assignment.activity,
        // activity: activityEntity.name,
        entityId: assignment.orgUnit,
        entityCode: assignment.orgUnitCode ?? '',
        entityName: assignment.orgUnitName ?? '',
        teamId: assignment.team,
        teamCode: assignment.teamCode ?? '',
        teamName: assignment.teamCode ?? '',
        scope: assignment.scope ?? EntityScope.Assigned,
        status: assignment.status ?? AssignmentStatus.NOT_STARTED,
        // dueDate: activityEntity.startDate != null
        //     ? AssignmentModel.calculateAssignmentDate(
        //         activityEntity.startDate, assignment.startDay)
        //     : null,
        startDay: assignment.startDay,
        rescheduledDate: assignment.startDate != null
            ? DateTime.parse(
                DateHelper.fromDbUtcToUiLocalFormat(assignment.startDate!))
            : null,
        // allocatedResources: managedTeams.length > 0
        //     ? resourceHeaders
        //         .asMap()
        //         .map((k, v) => MapEntry(v, assignment.allocatedResources[v]))
        //     : {for (var i in resourceHeaders) i: 0},
        // reportedResources: sumActualResources(submissions, resourceHeaders),
        forms: assignment.forms,
      );
    }).toList();

    final assignmentModels = await Future.wait<AssignmentModel>(futures);
    return assignmentModels;
  }

  void updateAssignmentStatus(
      AssignmentStatus? status, String assignmentId) async {
    // final previousState = await future;

    Assignment? assignment =
        await D2Remote.assignmentModuleD.assignment.byId(assignmentId).getOne();
    if (assignment != null) {
      DataFormSubmission toUpdate = DataFormSubmission.fromJson({
        ...assignment.toJson(),
        'status': status,
        'lastModifiedDate': DateHelper.nowUtc()
      });

      await D2Remote.assignmentModuleD.assignment
          .setData(toUpdate)
          .save(saveOptions: SaveOptions(skipLocalSyncStatus: false));
    }

    ref.invalidateSelf();
    await future;
  }
}
