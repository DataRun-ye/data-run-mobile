import 'package:d_sdk/core/sync/model/sync_config.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/users.table.dart';
import 'package:drift/drift.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase>
    with _$UsersDaoMixin, BaseDaoMixin<User> {
  UsersDao(AppDatabase db) : super(db);

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
  $UsersTable get table => users;
}
