import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/auth/user/entities/d_user.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/team_form_permission.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:datarunmobile/commons/helpers/collections.dart';
import 'package:datarunmobile/core/models/d_identifiable_model.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:datarunmobile/data_run/d_activity/activity_model.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity.provider.g.dart';

@riverpod
ActivityModel activityModel(ActivityModelRef ref) {
  throw UnimplementedError();
}

@riverpod
Future<List<ActivityModel>> activities(ActivitiesRef ref) async {
  final IList<TeamModel> managedTeams =
      await ref.watch(teamsProvider(EntityScope.Managed).future);

  final IList<TeamModel> assignedTeams =
      await ref.watch(teamsProvider(EntityScope.Assigned).future);

  // <form, downloaded>
  final List<Pair<TeamFormPermission, bool>> userForms =
  await ref.watch(userAvailableFormsProvider.future);

  final User? user = await D2Remote.userModule.user.getOne();

  final List<Activity> userEnabledActivities = await D2Remote
      .activityModuleD.activity
      .where(attribute: 'disabled', value: false)
      .get();
  //
  final List<ActivityModel> userActivities = [];

  for (final activity in userEnabledActivities) {
    final activityAssignedTeam =
        assignedTeams.where((t) => t.activity == activity.id).firstOrNull;
    final List<TeamModel> activityManagedTeams =
        managedTeams.where((t) => t.activity == activity.id).toList();
    final List<Assignment> assignedAssignment = await D2Remote
        .assignmentModuleD.assignment
        .where(attribute: 'team', value: activityAssignedTeam?.id ?? '')
        .get();
    final List<Assignment> managedAssignments = await D2Remote
        .assignmentModuleD.assignment
        .whereIn(
            attribute: 'team',
            values: managedTeams.map((t) => t.id!).toList(),
            merge: true)
        .get();
    final assignedOrgUnits = await D2Remote.organisationUnitModuleD.orgUnit
        .byIds(assignedAssignment.map((a) => a.orgUnit as String).toList())
        .get();

    final managedOrgUnits = await D2Remote.organisationUnitModuleD.orgUnit
        .byIds(managedAssignments.map((a) => a.orgUnit as String).toList())
        .get();

    userActivities.add(
      ActivityModel(
        user: IdentifiableModel.fromIdentifiable(identifiableEntity: user!),
        assignedTeam: activityAssignedTeam,
        activity: IdentifiableModel.fromIdentifiable(
            identifiableEntity: activity,
            properties: IMap({
              'startDate': activity.startDate,
              'endDate': activity.endDate,
            })),
        managedAssignments: managedAssignments.length,
        assignedAssignments: assignedAssignment.length,
        assignedForms: userForms,
        managedTeams: activityManagedTeams,
        orgUnits: [
          ...managedOrgUnits,
          ...assignedOrgUnits
        ].map((o) => IdentifiableModel.fromIdentifiable(identifiableEntity: o)),
      ),
    );
  }

  return userActivities;
}
