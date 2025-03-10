import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/metadatarun/activity/entities/d_activity.entity.dart';
import 'package:d2_remote/modules/metadatarun/project/entities/d_project.entity.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activities_access_repository.g.dart';

@Riverpod(keepAlive: true)
ActivitiesAccessRepository activitiesAccessRepository(
    ActivitiesAccessRepositoryRef ref) {
  return ActivitiesAccessRepository();
}

class ActivitiesAccessRepository {
  /// All available teams including disabled
  Future<IList<Team>> getAllTeams() async {
    final List<Team> teams = await D2Remote.teamModuleD.team.get();

    return teams.toIList();
  }

  /// All available activities including disabled
  Future<IList<Activity>> getAllActivities() async {
    final List<Activity> activities =
        await D2Remote.activityModuleD.activity.get();

    return activities.toIList();
  }

  /// All available projects including disabled
  Future<IList<DProject>> getAllProjects() async {
    final List<DProject> projects = await D2Remote.projectModuleD.project.get();

    return projects.toIList();
  }

  /// the team is in active activity
  Future<bool> teamIsInActiveActivity(Team team) async {
    final List<Activity> enabledActivities = await D2Remote
        .activityModuleD.activity
        .where(attribute: 'disabled', value: false)
        .get();

    return enabledActivities
        .any((Activity activity) => activity.id == team.activity);
  }

  /// activity is Active and has one or more active teams assigned to user
  Future<bool> activityWithActiveTeams(String activityUid) async {
    final List<Team> enabledTeams = await D2Remote.teamModuleD.team
        .byActivity(activityUid)
        .where(attribute: 'disabled', value: false)
        .get();

    return enabledTeams.any((Team team) => team.disabled = false);
  }

  /// project has one or more active activities
  Future<bool> projectHasActiveActivities(DProject project) async {
    final List<Activity> enabledActivities = await D2Remote
        .activityModuleD.activity
        .where(attribute: 'disabled', value: false)
        .get();

    return enabledActivities
        .any((Activity activity) => activity.project == project.id);
  }

  ///
  /// Only Enabled
  /// Only Active teams (Enabled)
  Future<IList<Team>> getActiveTeams() async {
    /// get all teams from teamsProvider and filter disabled
    final IList<Team> enabledTeams = await getAllTeams().then(
        (IList<Team> teams) =>
            teams.where((Team team) => !team.disabled).toIList());

    /// get all activities from activitiesProvider and filter disabled
    final IList<Activity> enabledActivities = await getAllActivities().then(
        (IList<Activity> activities) => activities
            .where((Activity activity) => !activity.disabled)
            .toIList());

    /// Predicate<T>
    bool teamInActiveActivity(Team team) => enabledActivities
        .any((Activity activity) => activity.id == team.activity);

    return enabledTeams.where(teamInActiveActivity).toIList();
  }

  /// Only Active activities (Enabled)
  Future<IList<Activity>> getActiveActivities() async {
    /// get all teams from teamsProvider and filter disabled
    final IList<Team> enabledTeams = await getAllTeams().then(
        (IList<Team> teams) =>
            teams.where((Team team) => !team.disabled).toIList());

    /// get all activities from activitiesProvider and filter disabled
    final IList<Activity> enabledActivities = await getAllActivities().then(
        (IList<Activity> activities) => activities
            .where((Activity activity) => !activity.disabled)
            .toIList());

    /// Predicate<T>
    bool activityHasActiveTeam(Activity activitie) =>
        enabledTeams.any((Team team) => team.activity == activitie.id);

    return enabledActivities.where(activityHasActiveTeam).toIList();
  }

  /// Only Active projects (Enabled)
  Future<IList<DProject>> getActiveProjects() async {
    final List<DProject> projects = await D2Remote.projectModuleD.project.get();

    final List<DProject> enabledProjects = <DProject>[];

    for (final DProject project in projects) {
      final bool projectIsActive = await projectHasActiveActivities(project);
      if (projectIsActive) {
        enabledProjects.add(project);
      }
    }

    return enabledProjects.toIList();
  }

  // /// Only Active forms (Enabled)
  // /// that has active activity and active team
  // Future<IList<FormTemplate>> getActiveForms() async {
  //   final List<FormTemplate> forms = await D2Remote.formModule.form.get();
  //
  //   final List<FormTemplate> enabledForms = [];
  //
  //   for (final form in forms) {
  //     final formActivityIsActive =
  //         await activityIsActiveWithActiveTeams(form.activity);
  //     if (formActivityIsActive) {
  //       enabledForms.add(form);
  //     }
  //   }
  //   return enabledForms.toIList();
  // }

  // /// Only Active forms (Enabled)
  // /// that has active activity and active team
  // Future<IList<FormTemplate>> getActiveFormsByActivity(
  //     [String? activityUid]) async {
  //   FormTemplateQuery query = D2Remote.formModule.form;
  //   if(activityUid != null) {
  //     query = query.where(attribute: 'activity', value: activityUid);
  //   }
  //   final List<FormTemplate> forms = await D2Remote.formModule.form.get();
  //
  //   final List<FormTemplate> enabledForms = [];
  //
  //   for (final form in forms) {
  //     final formActivityIsActive =
  //         await activityIsActiveWithActiveTeams(form.activity);
  //     if (formActivityIsActive) {
  //       enabledForms.add(form);
  //     }
  //   }
  //   return enabledForms.toIList();
  // }

  // /// Only Active forms (Enabled)
  // Future<Team?> getActivityTeam(String activityUid) async {
  //   return D2Remote.teamModuleD.team
  //       .where(attribute: 'activity', value: activityUid)
  //       .getOne();
  // }
}
