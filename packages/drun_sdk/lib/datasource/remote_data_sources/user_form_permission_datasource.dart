import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

class UserFormAccessesDatasource
    extends BaseDataSource<$UserFormPermissionsTable, UserFormPermission>
    implements MetaDataSource<UserFormPermission> {
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
