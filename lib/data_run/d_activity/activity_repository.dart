// import 'package:d2_remote/d2_remote.dart';
// import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
// import 'package:d2_remote/modules/metadatarun/activity/queries/d_activity.query.dart';
// import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
//
// // const cat = Environment('cat');
// // const chuck = Environment('chuck');
//
// class ActivityRepository {
//   ActivityRepository({required this.query});
//
//   final ActivityQuery query;
//   Future<Team> getAssignedTeam(String activity) {
//     return D2Remote.teamModuleD.team.where(attribute: 'activity', value: activity).getOne();
//   }
//   Future<List<Activity>> getUserActivities() {
//     final List<Team> managedTeams =
//         await ref.watch(teamsProvider(EntityScope.Managed).future);
//
//     final List<Team> assignedTeams =
//         await ref.watch(teamsProvider(EntityScope.Assigned).future);
//
//     final DUser? user = await D2Remote.userModule.user.getOne();
//
//     final List<ActivityModel> activities = [];
//
//     for (var assigned in assignedTeams) {
//       final Activity? activity = await D2Remote.activityModuleD.activity
//           .byId(assigned.activity!)
//           .where(attribute: 'disabled', value: false)
//           .getOne();
//       final activityManagedTeams = managedTeams
//           .where((t) => t.activity == activity?.id && activity!.disabled == false)
//           .toList();
//       final List<Assignment> assignedAssignment = await D2Remote
//           .assignmentModuleD.assignment
//           .where(attribute: 'team', value: assigned.id)
//           .get();
//
//       final List<Assignment> managedAssignments = await D2Remote
//           .assignmentModuleD.assignment
//           .whereIn(
//           attribute: 'team',
//           values: managedTeams.map((t) => t.id!).toList(),
//           merge: true)
//           .get();
//
//       final assignedOrgUnits = await D2Remote.organisationUnitModuleD.orgUnit
//           .byIds(assignedAssignment.map((a) => a.orgUnit as String).toList())
//           .get();
//
//       final managedOrgUnits = await D2Remote.organisationUnitModuleD.orgUnit
//           .byIds(managedAssignments.map((a) => a.orgUnit as String).toList())
//           .get();
//
//       final assignedTeam =
//           assignedTeams.where((t) => t.activity == activity?.id).firstOrNull;
//       activities.add(
//         ActivityModel(
//           user: DRunEntity.fromIdentifiable(identifiableEntity: user!),
//           assignedTeam: assignedTeam != null
//               ? DRunEntity.fromIdentifiable(identifiableEntity: assignedTeam)
//               : null,
//           activity: activity != null
//               ? DRunEntity.fromIdentifiable(
//               identifiableEntity: activity,
//               properties: IMap({
//                 'startDate': activity.startDate,
//                 'endDate': activity.endDate,
//               }))
//               : null,
//           managedAssignments: managedAssignments.length,
//           assignedAssignments: assignedAssignment.length,
//           assignedForms: assignedTeam?.formPermissions.map((f) => f.form) ?? [],
//           managedTeams: activityManagedTeams
//               .map((t) => DRunEntity.fromIdentifiable(identifiableEntity: t)),
//           orgUnits: [...managedOrgUnits, ...assignedOrgUnits]
//               .map((o) => DRunEntity.fromIdentifiable(identifiableEntity: o)),
//         ),
//       );
//     }
//
//     return query.where(attribute: 'disabled', value: false).get();
//     // return activities;
//   }
//
// }
