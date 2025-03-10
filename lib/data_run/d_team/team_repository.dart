// class TeamRepository {
//   final List<TeamModel> assignedTeams = [];
//   final List<TeamModel> managedTeams = [];
//
//   Future<List<TeamModel>> getTeams() async{
//     final List<Team> teams = await D2Remote.teamModuleD.team
//         .where(attribute: 'scope', value: scope.name)
//         .get();
//
//     return teams
//         .where((t) => !t.disabled)
//         .map((t) => t..name = '${Intl.message('team')} ${t.code}')
//         .toList();
//   }
// }
