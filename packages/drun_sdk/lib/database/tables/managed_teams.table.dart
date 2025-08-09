import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'managed_team_cod_idx', columns: {#code})
class ManagedTeams extends Table with BaseTableMixin {
  TextColumn get code => text().nullable()();

  @ReferenceName("activityManagedTeams")
  TextColumn get activity => text().references(Activities, #id)();

  @ReferenceName("managedTeams")
  TextColumn get managedBy => text().references(Teams, #id)();
}
