import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';

// @injectable
class TeamConfiguration {
  Future<ManagedTeam?> managedTeamByUid(String uid) async {
    return DSdk.db.managers.managedTeams
        .filter((f) => f.id.equals(uid))
        .getSingleOrNull();
  }

  Future<Team?> teamByUid(String uid) async {
    return DSdk.db.managers.teams
        .filter((f) => f.id.equals(uid))
        .getSingleOrNull();
  }
}
