import 'package:d2_remote/modules/auth/user/entities/d_user.entity.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:datarun/data_run/d_team/team_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../core/models/d_run_entity.dart';

class ActivityModel with EquatableMixin {
  ActivityModel(
      {Iterable<TeamModel> managedTeams = const [],
      Iterable<DIdentifiable> orgUnits = const [],
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
      {Iterable<DTeam> managedTeams = const [],
      Iterable<OrgUnit> orgUnits = const [],
      Iterable<String> assignedForms = const [],
      DUser? user,
      DTeam? userTeam,
      DActivity? activity,
      int assignedAssignments = 0,
      int managedAssignments = 0}) {
    return ActivityModel(
      assignedAssignments: assignedAssignments,
      managedAssignments: managedAssignments,
      assignedForms: assignedForms,
      managedTeams: managedTeams.map((e) => TeamModel.fromIdentifiable(
          identifiableEntity: e, formPermissions: e.formPermissions)),
      orgUnits: orgUnits.map((e) => DIdentifiable(
            id: e.id,
            code: e.code,
            name: e.name,
          )),
      user: DIdentifiable(
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
          ? DIdentifiable(
              id: activity.id,
              code: activity.code,
              name: activity.name,
              disabled: activity.disabled)
          : null,
    );
  }

  final IList<TeamModel> managedTeams;
  final IList<DIdentifiable> orgUnits;
  final IList<String> assignedForms;
  final DIdentifiable user;
  final TeamModel? assignedTeam;
  final DIdentifiable? activity;

  final int assignedAssignments;
  final int managedAssignments;

  ActivityModel copyWith({
    Iterable<TeamModel>? managedTeams,
    Iterable<DIdentifiable>? orgUnits,
    Iterable<String>? assignedForms,
    DIdentifiable? user,
    TeamModel? userTeam,
    DIdentifiable? activity,
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
