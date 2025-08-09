import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'org_name_idx', columns: {#name})
@TableIndex(name: 'org_code_idx', columns: {#code}, unique: true)
@TableIndex(name: 'org_path_idx', columns: {#path}, unique: true)
@TableIndex(name: 'org_level_idx', columns: {#level})
class OrgUnits extends Table with BaseTableMixin, IdentifiableMixin {
  TextColumn get name => text()();

  TextColumn get code => text().nullable()();

  /// a comma separated ids for ancestor starting from root to this orgUnit
  TextColumn get path => text()();

  IntColumn get level => integer()();

  TextColumn get parent => text().references(OrgUnits, #id).nullable()();
}
