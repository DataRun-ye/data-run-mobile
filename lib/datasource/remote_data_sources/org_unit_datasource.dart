import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/datasource/base_datasource.dart';
import 'package:datarunmobile/datasource/metadata_datasource.dart';
import 'package:drift/drift.dart';

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
