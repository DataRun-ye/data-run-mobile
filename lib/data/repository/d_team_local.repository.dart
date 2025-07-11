// import 'package:d_sdk/d2_remote.dart';
// import 'package:d_sdk/modules/metadatarun/teams/entities/d_team.entity.dart';
// import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
// import 'package:datarunmobile/data/repository/identifiable.repository.dart';
// import 'package:injectable/injectable.dart';
//
// @Injectable(as: IdentifiableRepository<Team>)
// class DTeamLocalRepository implements IdentifiableRepository<Team> {
//   @override
//   Future<int> delete(String id) {
//     return D2Remote.teamModuleD.team.byId(id).delete();
//   }
//
//   @override
//   Future<Team?> getById(String id) {
//     return D2Remote.teamModuleD.team.byId(id).getOne();
//   }
//
//   @override
//   Future<List<Team>> getWhere(
//       {String? attribute, value, int? limit, int? offset}) {
//     if (attribute != null) {
//       return D2Remote.teamModuleD.team
//           .resetFilters()
//           .where(attribute: attribute, value: value)
//           .get(limit: limit, offset: offset);
//     }
//     return D2Remote.teamModuleD.team
//         .resetFilters()
//         .get(limit: limit, offset: offset);
//   }
//
//   @override
//   Future<Team> save(Team identifiable) async {
//     await D2Remote.teamModuleD.team.setData(identifiable).save();
//     return D2Remote.teamModuleD.team.byId(identifiable.id!).getOne();
//   }
// }
