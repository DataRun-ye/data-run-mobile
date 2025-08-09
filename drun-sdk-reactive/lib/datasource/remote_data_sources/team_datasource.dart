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
// @override
// String get resourceName => 'teams';
//
// @override
// Future<List<Team>> syncWithRemote(
//     {SyncConfig? options, ProgressCallback? progressCallback,}) async {
//   final resourcePath = '$resourceName$pathPostfix';
//   final response =
//       await apiClient.request(resourceName: resourcePath, method: 'get');
//
//   final raw = response.data;
//
//   /// expecting paged list ({ apiResourceName: [...] }),
//   List dataItems = raw?[resourceName]?.toList() ?? [];
//
//   List<ManagedTeam> managedTeams = [];
//   for (final item in dataItems) {
//     final managedTeamsJsonList = item['managedTeams'] as List?;
//     if (!managedTeams.isNullOrEmpty) {
//       managedTeams.addAll(managedTeamsJsonList!
//           .map<ManagedTeam>((t) => ManagedTeam.fromJson({
//                 ...t,
//                 'managedBy': item['uid'],
//                 'activity': item['activity']['uid']
//               }))
//           .toList());
//     }
//   }
//
//   final teams = dataItems.map((item) {
//     return fromApiJson({
//       ...item,
//       'id': item['uid']!,
//       'translations': (item['translations'] as List?) ?? [],
//     }, serializer: CustomSerializer());
//   }).toList();
//
//   progressCallback?.call(60);
//
//   if (teams.isNotEmpty) {
//     db.transaction(() async {
//       await db.batch((b) {
//         b.insertAllOnConflictUpdate(table, teams);
//       });
//       if (managedTeams.isNotEmpty) {
//         await db.batch((b) {
//           b.insertAllOnConflictUpdate(db.managedTeams, managedTeams);
//         });
//       }
//     });
//   }
//   progressCallback?.call(100);
//   return teams;
// }
//
