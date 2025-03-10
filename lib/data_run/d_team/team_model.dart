import 'package:d2_remote/modules/datarun_shared/utilities/team_form_permission.dart';
import 'package:d2_remote/shared/entities/identifiable.entity.dart';
import 'package:datarun/core/models/d_identifiable_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';

class TeamModel with EquatableMixin {
  factory TeamModel.fromIdentifiable(
      {required IdentifiableEntity identifiableEntity,
      String? activity,
      Iterable<TeamFormPermission> formPermissions = const IListConst([])}) {
    return TeamModel._(
        activity: activity,
        team: IdentifiableModel.fromIdentifiable(
            identifiableEntity: identifiableEntity),
        formPermissions: formPermissions);
  }

  TeamModel._(
      {required IdentifiableModel team,
      Iterable<TeamFormPermission>? formPermissions,
      this.activity})
      : this._team = team,
        this.formPermissions = IList.orNull(formPermissions) ?? IList();

  final IdentifiableModel _team;

  String? get name => '${Intl.message('team')} ${_team.code}';

  String? get id => _team.id;

  bool get disabled => _team.disabled;

  IMap<String, dynamic> get label => _team.label;

  IMap<String, dynamic> get properties => _team.properties;

  final String? activity;
  final IList<TeamFormPermission> formPermissions;

  @override
  List<Object?> get props => [_team, formPermissions];
}

class TeamSummary {
  TeamSummary({
    required this.id,
    required this.name,
    required this.assignmentsTotal,
    required this.assignmentsCompleted,
    required this.assignmentsOverdue,
    required this.resources,
    required this.activities,
  });

  final String id;
  final String name;
  final int assignmentsTotal;
  final int assignmentsCompleted;
  final int assignmentsOverdue;
  final List<Resource> resources;
  final List<ActivityFeedItem> activities;
}

class Resource {
  Resource({
    required this.name,
    required this.allocated,
    required this.used,
  });

  final String name;
  int allocated;
  int used;
}

class ActivityFeedItem {
  ActivityFeedItem({
    required this.title,
    required this.timestamp,
  });

  final String title;
  final String timestamp;
}
