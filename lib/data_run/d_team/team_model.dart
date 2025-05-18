import 'package:d_sdk/database/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class TeamModel with EquatableMixin {
  factory TeamModel.fromIdentifiable(
      {required String activity,
      required String id,
      required String name,
      required bool disabled,
      IMap<String, dynamic>? label,
      IMap<String, dynamic>? properties,
      Iterable<TeamFormPermission> formPermissions = const IListConst([])
      }) {
    return TeamModel._(
        activity: activity,
        id: id,
        name: name,
        disabled: disabled,
        label: label,
        properties: properties,
        formPermissions: formPermissions);
  }

  TeamModel._(
      {required this.id,
      required this.name,
      this.disabled = false,
      IMap<String, dynamic>? label,
      IMap<String, dynamic>? properties,
      Iterable<TeamFormPermission>? formPermissions,
      this.activity})
      : this.formPermissions = IList.orNull(formPermissions) ?? IList(),
        this.label = label ?? IMap(),
        this.properties = properties ?? IMap();

  final String name; // => '${Intl.message('team')} ${_team.code}';

  final String id; // => _team.id;

  final bool disabled; // => _team.disabled;

  final IMap<String, dynamic> label; // => _team.label;

  final IMap<String, dynamic> properties; // => _team.properties;

  final String? activity;
  final IList<TeamFormPermission> formPermissions;

  @override
  List<Object?> get props => [id, name, disabled, activity, formPermissions];
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
