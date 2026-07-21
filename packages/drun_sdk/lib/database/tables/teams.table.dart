import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'team_cod_idx', columns: {#code})
@TableIndex(name: 'team_disabled_idx', columns: {#disabled})
class Teams extends Table with BaseTableMixin {
  TextColumn get code => text().nullable()();

  BoolColumn get disabled => boolean().nullable()();

  @ReferenceName("assignedTeams")
  TextColumn get activity => text().references(Activities, #id)();
}
