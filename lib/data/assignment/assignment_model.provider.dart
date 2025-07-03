import 'package:d2_remote/core/datarun/utilities/date_helper.dart';
import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/data_value/entities/data_form_submission.entity.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/team_form_permission.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:d2_remote/shared/utilities/save_option.util.dart';
import 'package:datarunmobile/commons/helpers/collections.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
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

    // <form, downloaded>
    final List<Pair<TeamFormPermission, bool>> userForms =
        await ref.watch(userAvailableFormsProvider.future);

    final futures =
        assignments.map<Future<AssignmentModel>>((assignment) async {
      return AssignmentModel(
        id: assignment.id!,
        activityId: assignment.activity,
        entityId: assignment.orgUnit,
        entityCode: assignment.orgUnitCode ?? '',
        entityName: assignment.orgUnitName ?? '',
        teamId: assignment.team,
        teamCode: assignment.teamCode ?? '',
        teamName: assignment.teamCode ?? '',
        scope: assignment.scope ?? EntityScope.Assigned,
        status: assignment.status ?? AssignmentStatus.NOT_STARTED,
        startDay: assignment.startDay,
        rescheduledDate: assignment.startDate != null
            ? DateTime.parse(
                DateHelper.fromDbUtcToUiLocalFormat(assignment.startDate!))
            : null,
        userForms: userForms
            .where((uf) =>
                assignment.forms.contains(uf.first.form) &&
                uf.first.team == assignment.team)
            .toList(),
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
