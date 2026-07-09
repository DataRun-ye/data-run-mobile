import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'party_name_idx', columns: {#name})
class Parties extends Table with BaseTableMixin, IdentifiableMixin {
  @override
  String get tableName => 'parties';

  TextColumn get uid => text()();

  TextColumn get name => text()();

  TextColumn get code => text().nullable()();

  TextColumn get type =>
      text().map(const EnumNameConverter(PartyType.values))();

  TextColumn get sourceType =>
      text().map(const EnumNameConverter(SourceType.values))();

  TextColumn get sourceId => text()();

  TextColumn get parentId => text().nullable()();
}

enum PartyType { INTERNAL, EXTERNAL }

enum SourceType { ORG_UNIT, TEAM, USER, STATIC, EXTERNAL }
