import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.team)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class TeamDatasource extends BaseDataSource<$TeamsTable, Team>
    implements MetaDataSource<Team> {
  @override
  String get resourceName => 'teams';

  /// Step 2: pull out ManagedTeam companions
  @override
  Future<List<CompanionInsert>> extractExtraEntities(
      List<Map<String, dynamic>> raw) async {
    final inserts = <CompanionInsert>[];
    for (var item in raw) {
      final managed = (item['managedTeams'] as List? ?? []).map((t) {
        final json = {
          ...t as Map<String, dynamic>,
          'managedBy': item['uid'],
          'activity': item['activity']['uid'],
        };
        return ManagedTeam.fromJson(json, serializer: CustomSerializer());
      });
      for (var m in managed) {
        inserts.add(CompanionInsert(db.managedTeams, m));
      }
    }
    return inserts;
  }

  @override
  Team mapRemoteItem(Map<String, dynamic> json) {
    final base = super.mapRemoteItem(json);
    final disabledActivity = (json['activity']['disabled'] ?? false) == true;
    return base.copyWith(
      disabled: Value(disabledActivity || base.disabled == true),
    );
  }

  @override
  Future<void> disableStale(List<Object> liveIds) async {
    await (db.update(table)
          ..where((t) => t.columnsByName['id']!.isNotIn(liveIds)))
        .write(RawValuesInsertable({
      'disabled': Variable<bool>(true),
    }));
  }

  @override
  Team fromApiJson(Map<String, dynamic> data, {ValueSerializer? serializer}) {
    final activity = data['activity']['uid'];
    final disabled =
        data['activity']['disabled'] == true || data['disabled'] == true;
    return Team.fromJson({
      ...data,
      'activity': activity,
      'disabled': disabled,
    }, serializer: serializer);
  }

  @override
  $TeamsTable get table => db.teams;
}
