import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/tables/org_units.table.dart';
import 'package:drift/drift.dart';

part 'org_units_dao.g.dart';

@DriftAccessor(tables: [OrgUnits])
class OrgUnitsDao extends DatabaseAccessor<AppDatabase>
    with _$OrgUnitsDaoMixin, BaseDaoMixin<OrgUnit> {
  OrgUnitsDao(AppDatabase db) : super(db);

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
  $OrgUnitsTable get table => orgUnits;
}
