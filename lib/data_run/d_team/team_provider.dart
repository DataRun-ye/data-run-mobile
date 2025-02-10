import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:datarun/data_run/d_team/team_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'team_provider.g.dart';

// @riverpod
// TeamRepository teamRepository(TeamRepositoryRef ref) {
//   return TeamRepository();
// }

@riverpod
class Teams extends _$Teams {
  @override
  Future<IList<TeamModel>> build(EntityScope scope) async {
    final List<DTeam> teams = await D2Remote.teamModuleD.team
        .where(attribute: 'scope', value: scope.name)
        .get();

    return teams
        .where((t) => !t.disabled)
        .map((t) => t..name = '${Intl.message('team')} ${t.code}')
        .map((t) => TeamModel.fromIdentifiable(
            identifiableEntity: t,
            activity: t.activity,
            formPermissions: t.formPermissions))
        .toList()
        .lock;
  }
}
