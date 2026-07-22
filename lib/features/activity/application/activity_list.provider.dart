import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/activity_model.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final activityListProvider = FutureProvider.autoDispose<List<ActivityModel>>(
  (ref) => loadActivityList(appLocator<AppDatabase>()),
);

Future<List<ActivityModel>> loadActivityList(AppDatabase db) async {
  final assignedTeams = await db.managers.teams
      .map((team) => IdentifiableModel(
            id: team.id,
            name: '${Intl.message('team')} ${team.code}',
            code: team.code,
            properties: {'activity': team.activity},
          ))
      .get();
  final managedTeams = await db.managers.managedTeams
      .map((team) => IdentifiableModel(
            id: team.id,
            name: '${Intl.message('team')} ${team.code}',
            code: team.code,
            properties: {'activity': team.activity},
          ))
      .get();
  final activities = await db.managers.activities.get();
  final result = <ActivityModel>[];

  for (final activity in activities) {
    final assignedTeam = assignedTeams
        .where((team) => team.properties['activity'] == activity.id)
        .firstOrNull;
    final activityManagedTeams = managedTeams
        .where((team) => team.properties['activity'] == activity.id)
        .toList();
    final assignedAssignments = await db.managers.assignments
        .filter((filter) => filter.team.id(assignedTeam?.id))
        .get();
    final managedAssignments = await db.managers.assignments
        .filter((filter) =>
            filter.team.id.isIn(managedTeams.map((team) => team.id)))
        .get();

    result.add(ActivityModel(
      assignedTeam: assignedTeam,
      id: activity.id,
      disabled: activity.disabled ?? false,
      name: activity.name,
      managedAssignments: managedAssignments.length,
      assignedAssignments: assignedAssignments.length,
      managedTeams: activityManagedTeams,
    ));
  }

  return result;
}
