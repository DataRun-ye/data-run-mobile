import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/teams.table.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:drift/drift.dart';

part 'teams_dao.g.dart';

@DriftAccessor(tables: [Teams])
class TeamsDao extends DatabaseAccessor<AppDatabase>
    with _$TeamsDaoMixin, BaseDaoMixin<Team> {
  TeamsDao(AppDatabase db) : super(db);

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
  SimpleSelectStatement<$TeamsTable, Team> get engine =>
      select(table)..where((u) => u.disabled.isNotValue(true));

  @override
  $TeamsTable get table => teams;
}
