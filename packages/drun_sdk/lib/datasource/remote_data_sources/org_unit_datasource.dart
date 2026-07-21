import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/datasource/abstract_datasource.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:d_sdk/datasource/metadata_datasource.dart';
import 'package:d_sdk/datasource/remote_datasource_order_map.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.orgUnit)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class OrgUnitDatasource extends BaseDataSource<$OrgUnitsTable, OrgUnit>
    implements MetaDataSource<OrgUnit> {
  @override
  String get resourceName => 'orgUnits';

  @override
  OrgUnit fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final parent = data['parent']?['uid'] ?? data['parent']?['id']?.toString();
    return OrgUnit.fromJson({...data, 'parent': parent},
        serializer: serializer);
  }

  @override
  $OrgUnitsTable get table => db.orgUnits;
}
