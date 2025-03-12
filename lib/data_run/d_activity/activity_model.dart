import 'package:d2_remote/modules/auth/user/entities/d_user.entity.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:datarunmobile/core/models/d_identifiable_model.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class ActivityModel with EquatableMixin {
  ActivityModel(
      {Iterable<TeamModel> managedTeams = const [],
      Iterable<IdentifiableModel> orgUnits = const [],
      Iterable<String> assignedForms = const [],
      this.assignedAssignments = 0,
      this.managedAssignments = 0,
      required this.user,
      this.assignedTeam,
      this.activity})
      : this.managedTeams = IList(managedTeams),
        this.orgUnits = IList(orgUnits),
        this.assignedForms = IList(assignedForms);

  factory ActivityModel.fromIdentifiable(
      {Iterable<Team> managedTeams = const [],
      Iterable<OrgUnit> orgUnits = const [],
      Iterable<String> assignedForms = const [],
      User? user,
      Team? userTeam,
      Activity? activity,
      int assignedAssignments = 0,
      int managedAssignments = 0}) {
    return ActivityModel(
      assignedAssignments: assignedAssignments,
      managedAssignments: managedAssignments,
      assignedForms: assignedForms,
      managedTeams: managedTeams.map((e) => TeamModel.fromIdentifiable(
          identifiableEntity: e, formPermissions: e.formPermissions)),
      orgUnits: orgUnits.map((e) => IdentifiableModel(
            id: e.id,
            code: e.code,
            name: e.name,
          )),
      user: IdentifiableModel(
        id: user!.id,
        code: user.code,
        name: user.name,
      ),
      assignedTeam: userTeam != null
          ? TeamModel.fromIdentifiable(
              identifiableEntity: userTeam,
              formPermissions: userTeam.formPermissions)
          : null,
      activity: activity != null
          ? IdentifiableModel(
              id: activity.id,
              code: activity.code,
              name: activity.name,
              disabled: activity.disabled)
          : null,
    );
  }

  final IList<TeamModel> managedTeams;
  final IList<IdentifiableModel> orgUnits;
  final IList<String> assignedForms;
  final IdentifiableModel user;
  final TeamModel? assignedTeam;
  final IdentifiableModel? activity;

  final int assignedAssignments;
  final int managedAssignments;

  ActivityModel copyWith({
    Iterable<TeamModel>? managedTeams,
    Iterable<IdentifiableModel>? orgUnits,
    Iterable<String>? assignedForms,
    IdentifiableModel? user,
    TeamModel? userTeam,
    IdentifiableModel? activity,
  }) {
    return ActivityModel(
      assignedForms: assignedForms ?? this.assignedForms,
      managedTeams: managedTeams ?? this.managedTeams,
      orgUnits: orgUnits ?? this.orgUnits,
      user: user ?? this.user,
      assignedTeam: userTeam ?? this.assignedTeam,
      activity: activity ?? this.activity,
    );
  }

  @override
  List<Object?> get props =>
      [managedTeams, orgUnits, user, assignedTeam, activity, assignedForms];
}
