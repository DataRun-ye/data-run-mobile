import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/activity_model.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/core/util/string_extension.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ActivityListViewModel extends BaseViewModel {
  List<ActivityModel> activities = [];

  Future<List<IdentifiableModel>> teams({String? activity}) async {
    var query = appLocator<AppDatabase>().managers.teams;

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
    var query = appLocator<AppDatabase>().managers.managedTeams;

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

    final List<Activity> userEnabledActivities = await appLocator<AppDatabase>()
        .managers
        .activities
        // .filter((f) => f.disabled.not(true))
        .get();

    final List<ActivityModel> userActivities = [];

    for (final activity in userEnabledActivities) {
      final activityAssignedTeam = assignedTeams
          .where((t) => t.properties['activity'] == activity.id)
          .firstOrNull;
      final List<IdentifiableModel> activityManagedTeams = managed
          .where((t) => t.properties['activity'] == activity.id)
          .toList();
      final List<Assignment> assignedAssignment =
          await appLocator<AppDatabase>()
              .managers
              .assignments
              .filter((f) => f.team.id(activityAssignedTeam?.id))
              .get();

      final List<Assignment> managedAssignments =
          await appLocator<AppDatabase>()
              .managers
              .assignments
              .filter((f) => f.team.id.isIn(managed.map((t) => t.id)))
              .get();

      userActivities.add(
        ActivityModel(
          assignedTeam: activityAssignedTeam,
          id: activity.id,
          disabled: activity.disabled ?? false,
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
    // logDebug(activities.toString());
  }
}
