// import 'dart:async';
//
// import 'package:d_sdk/database/shared/shared.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:datarunmobile/commons/d_run_base_service.dart';
// import 'package:datarunmobile/commons/identifiable.repository.dart';
// import 'package:datarunmobile/core/models/d_run_identifiable.dart';
// import 'package:datarunmobile/data/activity/model/activity_model.dart';
// import 'package:datarunmobile/data/assignment/repository/assignment_query_model.dart';
// import 'package:datarunmobile/data/team/repository/team_query_model.dart';
// import 'package:injectable/injectable.dart';
//
// // @injectable
// class ActivityListService extends DRunBaseService<Activity, ActivityModel> {
//   ActivityListService(
//       super.repository, this._assignmentRepository, this._teamRepository);
//
//   final DRunBaseRepository<Assignment> _assignmentRepository;
//   final DRunBaseRepository<Team> _teamRepository;
//
//   @override
//   FutureOr<ActivityModel> createModel(Activity identifiable) async {
//     return ActivityModel.fromIdentifiable(
//         baseEntity: identifiable,
//         assignmentCount: await _getAssignmentCount(identifiable.id!),
//         assignedTeam: (await _getTeams(identifiable.id!, EntityScope.Assigned))
//             .firstOrNull
//             ?.code,
//         managedTeamCount:
//             (await _getTeams(identifiable.id!, EntityScope.Managed)).length);
//   }
//
//   Future<int> _getAssignmentCount(String activity) {
//     return _assignmentRepository.getCount(
//         query: AssignmentQueryModel(activity: activity));
//   }
//
//   Future<List<DRunIdentifiable>> _getTeams(
//       String activity, EntityScope scope) async {
//     final teams = await _teamRepository.get(
//         query: TeamQueryModel(activity: activity, scope: scope));
//
//     return teams
//         .map((t) => DRunIdentifiable.fromIdentifiable(baseEntity: t))
//         .toList();
//   }
// }
