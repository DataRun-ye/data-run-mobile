import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data/teams.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity.provider.g.dart';

@riverpod
ActivityModel activityModel(Ref ref) {
  throw UnimplementedError();
}

// @riverpod
// Future<List<ActivityModel>> activities(Ref ref) async {
//   // <form, downloaded>
//   final List<Pair<AssignmentForm, bool>> userForms =
//       await ref.watch(userAvailableFormsProvider().future);
//
//   final List<IdentifiableModel> assignedTeams =
//       await ref.watch(teamsProvider().future);
//
//   final List<IdentifiableModel> managedTeams =
//       await ref.watch(managedTeamsProvider().future);
//
//   final List<Activity> userEnabledActivities =
//       await DSdk.db.managers.activities.filter((f) => f.disabled.not(true)).get();
//
//   final List<ActivityModel> userActivities = [];
//
//   for (final activity in userEnabledActivities) {
//     final activityAssignedTeam = assignedTeams
//         .where((t) => t.properties['activity'] == activity.id)
//         .firstOrNull;
//     final List<IdentifiableModel> activityManagedTeams = managedTeams
//         .where((t) => t.properties['activity'] == activity.id)
//         .toList();
//     final List<Assignment> assignedAssignment = await DSdk
//         .db.managers.assignments
//         .filter((f) => f.team.id(activityAssignedTeam?.id))
//         .get();
//
//     final List<Assignment> managedAssignments = await DSdk
//         .db.managers.assignments
//         .filter((f) => f.team.id.isIn(managedTeams.map((t) => t.id)))
//         .get();
//
//     final assignedOrgUnits = await DSdk.db.managers.orgUnits
//         .filter((f) => f.id.isIn(assignedAssignment.map((a) => a.orgUnit)))
//         .get();
//
//     final managedOrgUnits = await DSdk.db.managers.orgUnits
//         .filter((f) => f.id.isIn(managedAssignments.map((a) => a.orgUnit)))
//         .get();
//
//     userActivities.add(
//       ActivityModel(
//         assignedTeam: activityAssignedTeam,
//         id: activity.id,
//         name: activity.name,
//         managedAssignments: managedAssignments.length,
//         assignedAssignments: assignedAssignment.length,
//         managedTeams: activityManagedTeams,
//       ),
//     );
//   }
//
//   return userActivities;
// }
