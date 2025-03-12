import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'team.provider.g.dart';

@riverpod
class Teams extends _$Teams {
  @override
  Future<IList<TeamModel>> build(EntityScope scope) async {
    final List<Team> teams = await D2Remote.teamModuleD.team
        .where(attribute: 'scope', value: scope.name)
        .get();

    return teams
        .where((t) => !t.disabled)
        .map((t) => TeamModel.fromIdentifiable(
            identifiableEntity: t,
            activity: t.activity,
            formPermissions: t.formPermissions))
        .toList()
        .lock;
  }
}
