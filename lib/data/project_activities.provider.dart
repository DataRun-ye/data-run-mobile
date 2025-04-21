import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_activities.provider.g.dart';

@riverpod
Future<List<Team>> userAssignedTeams(Ref ref,
    {String? activity}) async {
  List<Team> teams = await (activity != null
      ? DSdk.db.managers.teams
          .filter((f) => f.disabled(false) & f.activity.id(activity))
          .get()
      : DSdk.db.managers.teams.filter((f) => f.disabled.equals(false)).get());

  return teams;
}

@riverpod
FutureOr<List<Activity>> userAssignedActivities(Ref ref,
    {String? project}) async {
  final teams = await ref
      .watch(userAssignedTeamsProvider().future);
  final List<String> userActivitiesUids = teams
      .map((t) => t.activity)
      .toList();

  final List<Activity> activities = await DSdk.db.managers.activities
      .filter((f) => f.disabled(false) & f.id.isIn(userActivitiesUids))
      .get();

  return (project != null
          ? activities.where((t) => t.project == project)
          : activities)
      .toList();
}

@riverpod
Future<List<Activity>> projectActiveActivities(
    Ref ref, String project) async {
  /// get the list of active activities
  final List<Activity> activeActivities =
      await ref.watch(userAssignedActivitiesProvider(project: project).future);

  /// Filter activities By project Id
  return activeActivities.where((Activity t) => t.project == project).toList();
}

// @riverpod
// Future<List<FormTemplate>> activityForms(
//     ActivityFormsRef ref, String? activity) async {
//   final List<FormTemplate> activeForms = await D2Remote.formModule.formTemplate
//       // .withFormVersions()
//       .where(attribute: 'activity', value: activity)
//       .get();
//
//   return activeForms;
// }

@riverpod
Future<Team?> activityTeam(Ref ref,
    {required String activity}) async {
  return DSdk.db.managers.teams
      .filter((f) => f.activity.id(activity))
      .getSingleOrNull();
}
