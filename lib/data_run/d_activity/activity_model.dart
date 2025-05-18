import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';

class ActivityModel with EquatableMixin {
  ActivityModel({
    Iterable<TeamModel> managedTeams = const [],
    Iterable<IdentifiableModel> orgUnits = const [],
    Iterable<String> assignedForms = const [],
    this.assignedAssignments = 0,
    this.managedAssignments = 0,
    this.assignedTeam,
    required this.activity,
    this.startDate,
    this.endDate,
  })  : this.managedTeams = IList(managedTeams),
        this.orgUnits = IList(orgUnits),
        this.assignedForms = IList(assignedForms);

  factory ActivityModel.fromIdentifiable(
      {Iterable<Team> managedTeams = const [],
      Iterable<OrgUnit> orgUnits = const [],
      Iterable<String> assignedForms = const [],
      User? user,
      Team? userTeam,
      required Activity activity,
      int assignedAssignments = 0,
      int managedAssignments = 0}) {
    return ActivityModel(
      assignedAssignments: assignedAssignments,
      managedAssignments: managedAssignments,
      assignedForms: assignedForms,
      managedTeams: managedTeams.map((e) => TeamModel.fromIdentifiable(
          id: e.id,
          name: '${Intl.message('team')} ${e.code}',
          activity: e.activity,
          disabled: e.disabled ?? false)),
      orgUnits: orgUnits.map((e) => IdentifiableModel(
            id: e.id,
            code: e.code,
            name: e.name ?? '',
          )),
      activity: IdentifiableModel(
          id: activity.id,
          code: activity.code,
          name: activity.name ?? '',
          disabled: activity.disabled),
    );
  }

  final IList<TeamModel> managedTeams;
  final IList<IdentifiableModel> orgUnits;
  final IList<String> assignedForms;

  final TeamModel? assignedTeam;
  final IdentifiableModel activity;
  final DateTime? startDate;
  final DateTime? endDate;
  final int assignedAssignments;
  final int managedAssignments;

  ActivityModel copyWith({
    Iterable<TeamModel>? managedTeams,
    Iterable<IdentifiableModel>? orgUnits,
    Iterable<String>? assignedForms,
    TeamModel? userTeam,
    IdentifiableModel? activity,
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      ActivityModel(
        assignedForms: assignedForms ?? this.assignedForms,
        managedTeams: managedTeams ?? this.managedTeams,
        orgUnits: orgUnits ?? this.orgUnits,
        assignedTeam: userTeam ?? this.assignedTeam,
        activity: activity ?? this.activity,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  @override
  List<Object?> get props =>
      [managedTeams, orgUnits, assignedTeam, activity, assignedForms];
}
