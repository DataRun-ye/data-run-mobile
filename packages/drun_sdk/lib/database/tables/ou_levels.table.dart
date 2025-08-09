import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'level_name_idx', columns: {#name})
class OuLevels extends Table with BaseTableMixin, IdentifiableMixin {
  TextColumn get name => text()();

  TextColumn get code => text().nullable()();

  IntColumn get level => integer()();

  IntColumn get offlineLevels => integer().nullable()();
}
