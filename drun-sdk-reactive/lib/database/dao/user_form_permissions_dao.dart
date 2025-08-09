import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/user_form_permissions.dart';
import 'package:drift/drift.dart';

part 'user_form_permissions_dao.g.dart';

@DriftAccessor(tables: [UserFormPermissions])
class UserFormPermissionsDao extends DatabaseAccessor<AppDatabase>
    with _$UserFormPermissionsDaoMixin, BaseDaoMixin<UserFormPermission> {
  UserFormPermissionsDao(AppDatabase db) : super(db);

  @override
  String get resourceName => 'formPermissions';

  String get resourcePath => resourceName;

  /// no op, userFormPermission's id ={team, form}, this will be ignored
  @override
  dynamic extractId(Map<String, dynamic> json) => '';

  @override
  UserFormPermission fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    return UserFormPermission.fromJson({
      ...data,
    }, serializer: serializer);
  }

  @override
  $UserFormPermissionsTable get table => db.userFormPermissions;
}
