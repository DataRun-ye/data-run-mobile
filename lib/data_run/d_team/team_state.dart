import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamListProvider =
    StateNotifierProvider<TeamListNotifier, List<TeamSummary>>(
        (ref) => TeamListNotifier());

class TeamListNotifier extends StateNotifier<List<TeamSummary>> {
  TeamListNotifier() : super([]);

  void loadTeams(List<TeamSummary> teams) {
    state = teams;
  }

  void updateResources(String teamId, List<Resource> updatedResources) {
    state = state.map((team) {
      if (team.id == teamId) {
        return TeamSummary(
          id: team.id,
          name: team.name,
          assignmentsTotal: team.assignmentsTotal,
          assignmentsCompleted: team.assignmentsCompleted,
          assignmentsOverdue: team.assignmentsOverdue,
          resources: updatedResources,
          activities: team.activities,
        );
      }
      return team;
    }).toList();
  }
}

final filterProvider = StateProvider<String?>((ref) => null);
final sortProvider = StateProvider<String>((ref) => 'Alphabetical');
final expandedTeamsProvider =
    StateNotifierProvider<ExpandedTeamsNotifier, Set<String>>(
        (ref) => ExpandedTeamsNotifier());

class ExpandedTeamsNotifier extends StateNotifier<Set<String>> {
  ExpandedTeamsNotifier() : super({});

  void toggle(String teamId) {
    if (state.contains(teamId)) {
      state = {...state}..remove(teamId);
    } else {
      state = {...state}..add(teamId);
    }
  }
}
