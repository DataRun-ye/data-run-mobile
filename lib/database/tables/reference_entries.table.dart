import 'package:drift/drift.dart';

@TableIndex(
  name: 'reference_entry_scope_name_idx',
  columns: {#orgUnitUid, #displayName},
)
class ReferenceEntries extends Table {
  TextColumn get uid => text()();

  TextColumn get orgUnitUid => text()();

  TextColumn get displayName => text()();

  @override
  Set<Column<Object>> get primaryKey => {uid};
}
