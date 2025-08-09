import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'option_name_idx', columns: {#name})
@TableIndex(name: 'option_code_idx', columns: {#code})
class DataOptions extends Table with BaseTableMixin, IdentifiableMixin {
  TextColumn get name => text()();

  TextColumn get code => text()();

  @ReferenceName("options")
  TextColumn get optionSet => text().references(DataOptionSets, #id,
      onDelete: KeyAction.cascade, onUpdate: KeyAction.cascade)();

  IntColumn get order => integer().clientDefault(() => 0)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {optionSet, id},
        {optionSet, code}
      ];
}
