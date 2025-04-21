import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/core/models/d_identifiable_model.dart';
import 'package:datarunmobile/data/team/teams.provider.dart';
import 'package:datarunmobile/data_run/d_activity/activity_model.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity.provider.g.dart';

@riverpod
ActivityModel activityModel(Ref ref) {
  throw UnimplementedError();
}

@riverpod
Future<List<ActivityModel>> activities(Ref ref) async {
  final IList<TeamModel> managedTeams =
      await ref.watch(teamsProvider(EntityScope.Managed).future);

  final IList<TeamModel> assignedTeams =
      await ref.watch(teamsProvider(EntityScope.Assigned).future);

  final user = DSdk.dbManager;
  //await D2Remote.userModule.user.getOne();

  final List<Activity> userEnabledActivities =
      await DSdk.db.managers.activities.filter((f) => f.disabled(false)).get();
  // await D2Remote
  //     .activityModuleD.activity
  //     .where(attribute: 'disabled', value: false)
  //     .get();
  //
  final List<ActivityModel> userActivities = [];

  for (final activity in userEnabledActivities) {
    final activityAssignedTeam =
        assignedTeams.where((t) => t.activity == activity.id).firstOrNull;
    final List<TeamModel> activityManagedTeams =
        managedTeams.where((t) => t.activity == activity.id).toList();
    final List<Assignment> assignedAssignment = await DSdk
        .db.managers.assignments
        .filter((f) => f.team.id(activityAssignedTeam?.id))
        .get();
    // await D2Remote
    //     .assignmentModuleD.assignment
    //     .where(attribute: 'team', value: activityAssignedTeam?.id ?? '')
    //     .get();
    final List<Assignment> managedAssignments = await DSdk
        .db.managers.assignments
        .filter((f) => f.team.id.isIn(managedTeams.map((t) => t.id)))
        .get();
    // await D2Remote
    //     .assignmentModuleD.assignment
    //     .whereIn(
    //         attribute: 'team',
    //         values: managedTeams.map((t) => t.id!).toList(),
    //         merge: true)
    //     .get();
    final assignedOrgUnits = await DSdk.db.managers.orgUnits
        .filter((f) => f.id.isIn(assignedAssignment.map((a) => a.orgUnit)))
        .get();
    // await D2Remote.organisationUnitModuleD.orgUnit
    //     .byIds(assignedAssignment.map((a) => a.orgUnit as String).toList())
    //     .get();

    final managedOrgUnits = await DSdk.db.managers.orgUnits
        .filter((f) => f.id.isIn(managedAssignments.map((a) => a.orgUnit)))
        .get();

    // await D2Remote.organisationUnitModuleD.orgUnit
    //     .byIds(managedAssignments.map((a) => a.orgUnit as String).toList())
    //     .get();

    userActivities.add(
      ActivityModel(
        // user: IdentifiableModel(
        //   id: user.id,
        //   code: user.username,
        //   name: user.username,
        // ),
        assignedTeam: activityAssignedTeam,
        activity: IdentifiableModel(
            id: activity.id,
            code: activity.code,
            name: activity.name,
            properties: IMap({
              'startDate': activity.startDate,
              'endDate': activity.endDate,
            })),
        managedAssignments: managedAssignments.length,
        assignedAssignments: assignedAssignment.length,
        assignedForms:
            activityAssignedTeam?.formPermissions.map((f) => f.form) ??
                <String>[],
        managedTeams: activityManagedTeams,
        orgUnits: [
          ...managedOrgUnits,
          ...assignedOrgUnits
        ].map((o) => IdentifiableModel(id: o.id, name: o.name, code: o.code)),
      ),
    );
  }

  return userActivities;
}
