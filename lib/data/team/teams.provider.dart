import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/data_run/d_team/team_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teams.provider.g.dart';

@riverpod
class Teams extends _$Teams {
  @override
  Future<IList<TeamModel>> build(EntityScope scope) async {
    final db = DSdk.db;

    final List<Team> teams = await db.managers.teams
        // .filter((f) => f.scope.not(scope) | f.scope.isNull())
        .get();
    // await D2Remote.teamModuleD.team
    //     .where(attribute: 'scope', value: scope.name)
    //     .get();

    return teams
        .where((t) => !(t.disabled ?? false))
        .map((t) => TeamModel.fromIdentifiable(
            id: t.id,
            name: '${Intl.message('team')} ${t.code}',
            disabled: t.disabled ?? false,
            activity: t.activity,
            formPermissions: /*t.formPermissions ??*/ []))
        .toList()
        .lock;
  }
}
