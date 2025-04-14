// import 'package:d2_remote/d2_remote.dart';
// import 'package:d2_remote/di/injection.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
// import 'package:d2_remote/shared/queries/base.query.dart';
// import 'package:datarunmobile/core/d2_remote_extensions/base_query_extension.dart';
// import 'package:datarunmobile/commons/identifiable.repository.dart';
// import 'package:datarunmobile/commons/query/query_model.dart';
// import 'package:injectable/injectable.dart';
//
// // @LazySingleton(as: DRunBaseRepository<Team>)
// class DTeamLocalRepository extends DRunBaseRepository<Team> {
//   DTeamLocalRepository() : super(sdkLocator<TeamQuery>());
//
//   Future<List<String>> getTeamAssignedForms(String teamId) async {
//     final team = await entityQuery.byId(teamId).getOne();
//     return team!.formPermissions.map((t) => t.form).toList();
//   }
// }
