// import 'package:d_sdk/core/common/d_run_identifiable.dart';
// import 'package:d_sdk/database/shared/team_form_permission.dart';
// import 'package:datarunmobile/commons/helpers/collections.dart';
// import 'package:datarunmobile/data_run/d_team/team_model.dart';
// import 'package:equatable/equatable.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
//
// class ActivityModel with EquatableMixin {
//   ActivityModel(
//       {Iterable<TeamModel> managedTeams = const [],
//       Iterable<IdentifiableModel> orgUnits = const [],
//       Iterable<Pair<TeamFormPermission, bool>> assignedForms = const [],
//       this.assignedAssignments = 0,
//       this.managedAssignments = 0,
//       this.assignedTeam,
//       this.activity})
//       : this.managedTeams = IList(managedTeams),
//         this.orgUnits = IList(orgUnits),
//         this.assignedForms = IList(assignedForms);
//
//   final IList<TeamModel> managedTeams;
//   final IList<IdentifiableModel> orgUnits;
//   final IList<Pair<TeamFormPermission, bool>> assignedForms;
//   final TeamModel? assignedTeam;
//   final IdentifiableModel? activity;
//
//   final int assignedAssignments;
//   final int managedAssignments;
//
//   ActivityModel copyWith({
//     Iterable<TeamModel>? managedTeams,
//     Iterable<IdentifiableModel>? orgUnits,
//     Iterable<Pair<TeamFormPermission, bool>>? assignedForms,
//     TeamModel? userTeam,
//     IdentifiableModel? activity,
//   }) {
//     return ActivityModel(
//       assignedForms: assignedForms ?? this.assignedForms,
//       managedTeams: managedTeams ?? this.managedTeams,
//       orgUnits: orgUnits ?? this.orgUnits,
//       assignedTeam: userTeam ?? this.assignedTeam,
//       activity: activity ?? this.activity,
//     );
//   }
//
//   @override
//   List<Object?> get props =>
//       [managedTeams, orgUnits, assignedTeam, activity, assignedForms];
// }
