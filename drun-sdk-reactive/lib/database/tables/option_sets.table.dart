import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'option_set_name_idx', columns: {#name})
@TableIndex(name: 'option_set_code_idx', columns: {#code})
class DataOptionSets extends Table with BaseTableMixin, IdentifiableMixin {
  TextColumn get name => text()();

  TextColumn get code => text().nullable()();
}
