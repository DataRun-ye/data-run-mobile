import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandedTeamState extends StateNotifier<Set<int>> {
  ExpandedTeamState() : super({});

  void toggle(int teamId) {
    if (state.contains(teamId)) {
      state = {...state}..remove(teamId);
    } else {
      state = {...state}..add(teamId);
    }
  }
}

final expandedTeamProvider = StateNotifierProvider<ExpandedTeamState, Set<int>>(
  (ref) => ExpandedTeamState(),
);
