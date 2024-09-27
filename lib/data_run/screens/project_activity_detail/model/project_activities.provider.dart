import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/dynamic_form.entity.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/active_status.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_activities.provider.g.dart';

@riverpod
Future<List<DTeam>> userAssignedTeams(UserAssignedTeamsRef ref,
    {ActiveStatus activeStatus = ActiveStatus.EnabledOnly,
    String? activity}) async {
  List<DTeam> teams = await (activity != null
      ? D2Remote.teamModuleD.team
          .byActivity(activity)
          .byActivityStatus(activeStatus)
          .get()
      : D2Remote.teamModuleD.team.byActivityStatus(activeStatus).get());

  return teams;
}

@riverpod
FutureOr<List<DActivity>> userAssignedActivities(UserAssignedActivitiesRef ref,
    {ActiveStatus activeStatus = ActiveStatus.EnabledOnly,
    String? project}) async {
  final teams = await ref
      .watch(userAssignedTeamsProvider(activeStatus: activeStatus).future);
  final List<String> userActivitiesUids = teams
      .takeWhile((t) => t.activity != null)
      .map((t) => t.activity!)
      .toList();

  final List<DActivity> activities = await D2Remote.activityModuleD.activity
      .byIds(userActivitiesUids)
      .byActivityStatus(activeStatus)
      .get();

  return (project != null
          ? activities.where((t) => t.project == project)
          : activities)
      .toList();
}

@riverpod
Future<List<DActivity>> projectActiveActivities(
    ProjectActiveActivitiesRef ref, String project) async {
  /// get the list of active activities
  final List<DActivity> activeActivities =
      await ref.watch(userAssignedActivitiesProvider(project: project).future);

  /// Filter activities By project Id
  return activeActivities.where((DActivity t) => t.project == project).toList();
}

@riverpod
Future<List<FormTemplate>> activityForms(
    ActivityFormsRef ref, String? activity) async {
  final List<FormTemplate> activeForms = await D2Remote.formModule.formTemplate
      .where(attribute: 'activity', value: activity)
      .get();

  return activeForms;
}

@riverpod
Future<DTeam?> activityTeam(ActivityTeamRef ref, String? activity) async {
  return D2Remote.teamModuleD.team
      .where(attribute: 'activity', value: activity)
      .getOne();
}
