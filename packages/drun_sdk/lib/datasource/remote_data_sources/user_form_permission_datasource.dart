import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/abstract_datasource.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:d_sdk/datasource/remote_datasource_order_map.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.userFormAccess)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
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
