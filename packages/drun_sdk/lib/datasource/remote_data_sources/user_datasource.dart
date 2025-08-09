import 'package:d_sdk/core/sync/model/sync_config.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.user)
@Injectable(scope: UserSession.activeSessionScope)
class UserDatasource extends BaseDataSource<$UsersTable, User>
    implements MetaDataSource<User> {
  @override
  String get resourceName => 'myDetails';

  @override
  Future<List<Map<String, dynamic>>> getOnlineRaw({
    SyncConfig? options,
    Map<String, dynamic>? params,
  }) async {
    final response =
        await apiClient.request(resourceName: resourceName, method: 'get');

    final raw = response.data != null ? [response.data] : [];
    return raw.cast<Map<String, dynamic>>();
  }

  @override
  User fromApiJson(Map<String, dynamic> data, {ValueSerializer? serializer}) {
    final authorities = (data['authorities'] as List<dynamic>)
        .map<String>((e) => e['authority'] as String)
        .toList();

    return User.fromJson({
      ...data,
      'username': data['login'],
      'authorities': authorities,
    }, serializer: serializer);
  }

  @override
  $UsersTable get table => db.users;

// Future<List<User>> syncWithRemote(
//     {SyncConfig? options, ProgressCallback? progressCallback,}) async {
//   final response =
//   await apiClient.request(resourceName: resourceName, method: 'get');
//
//   final raw = response.data;
//
//   List dataItems = raw != null ? [raw] : [];
//   final authorities = dataItems.map((item) {
//     item['authorities'] = false;
//     return UserAuthority.fromJson({
//       ...item,
//       'name': item['authority']!,
//       'user': item['uid'],
//     }, serializer: CustomSerializer());
//   }).toList();
//   progressCallback?.call(70);
//
//   final remoteData = dataItems.map((item) {
//     item['dirty'] = false;
//     item['synced'] = true;
//
//     return fromApiJson({
//       ...item,
//       'id': item['uid']!,
//     }, serializer: CustomSerializer());
//   }).toList();
//
//   progressCallback?.call(80);
//
//   if (remoteData.isNotEmpty) {
//     db.transaction(() async {
//       await db.batch((b) {
//         b.insertAllOnConflictUpdate(table, remoteData);
//       });
//       await db.batch((b) {
//         b.insertAllOnConflictUpdate(db.userAuthorities, authorities);
//       });
//     });
//   }
//   progressCallback?.call(100);
//   return remoteData;
// }
}
