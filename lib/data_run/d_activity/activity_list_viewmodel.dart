import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/dao.dart';
import 'package:d_sdk/database/shared/activity_model.dart';
import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/commons/extensions/string_extension.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ActivityListViewModel extends BaseViewModel {
  final ActivitiesDao _dao = DSdk.activity;

  List<ActivityModel> activities = [];

  Future<List<IdentifiableModel>> teams({String? activity}) async {
    var query = DSdk.db.managers.teams;

    if (activity.isNotNullOrEmpty) {
      query.filter((f) => f.activity.id(activity));
    }

    return query
        .map((t) => IdentifiableModel(
            id: t.id,
            name: '${Intl.message('team')} ${t.code}',
            code: t.code,
            properties: {'activity': t.activity}))
        .get();
  }

  Future<List<IdentifiableModel>> managedTeams(
      {String? team, String? activity}) async {
    var query = DSdk.db.managers.managedTeams;

    if (team.isNotNullOrEmpty) {
      query.filter((f) => f.managedBy.id(team));
    }
    if (activity.isNotNullOrEmpty) {
      query.filter((f) => f.activity.id(activity));
    }
    return query
        .map((t) => IdentifiableModel(
            id: t.id,
            name: '${Intl.message('team')} ${t.code}',
            code: t.code,
            properties: {'activity': t.activity}))
        .get();
  }

  /// This is the stream that Stacked will subscribe to.
  Future<void> _fetch() async {
    final List<IdentifiableModel> assignedTeams = await teams();
    final List<IdentifiableModel> managed = await managedTeams();

    final List<Activity> userEnabledActivities = await DSdk
        .db.managers.activities
        .filter((f) => f.disabled(false))
        .get();

    final List<ActivityModel> userActivities = [];

    for (final activity in userEnabledActivities) {
      final activityAssignedTeam = assignedTeams
          .where((t) => t.properties[activity] == activity.id)
          .firstOrNull;
      final List<IdentifiableModel> activityManagedTeams =
          managed.where((t) => t.properties[activity] == activity.id).toList();
      final List<Assignment> assignedAssignment = await DSdk
          .db.managers.assignments
          .filter((f) => f.team.id(activityAssignedTeam?.id))
          .get();

      final List<Assignment> managedAssignments = await DSdk
          .db.managers.assignments
          .filter((f) => f.team.id.isIn(managed.map((t) => t.id)))
          .get();

      final assignedOrgUnits = await DSdk.db.managers.orgUnits
          .filter((f) => f.id.isIn(assignedAssignment.map((a) => a.orgUnit)))
          .get();

      final managedOrgUnits = await DSdk.db.managers.orgUnits
          .filter((f) => f.id.isIn(managedAssignments.map((a) => a.orgUnit)))
          .get();

      userActivities.add(
        ActivityModel(
          assignedTeam: activityAssignedTeam,
          id: activity.id,
          name: activity.name,
          managedAssignments: managedAssignments.length,
          assignedAssignments: assignedAssignment.length,
          managedTeams: activityManagedTeams,
        ),
      );
    }

    activities.addAll(userActivities);
  }

  Future<void> runFuture() async {
    await runBusyFuture(_fetch());
    logDebug(activities.toString());
  }
}
