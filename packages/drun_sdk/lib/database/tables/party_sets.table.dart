import 'package:d_sdk/database/converters/party_set_spec.converter.dart';
import 'package:d_sdk/database/shared/party/party_set_kind.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'party_set_name_idx', columns: {#name})
class PartySets extends Table with BaseTableMixin, IdentifiableMixin {
  TextColumn get uid => text()();

  TextColumn get name => text()();

  TextColumn get code => text().nullable()();

  TextColumn get kind =>
      text().map(const EnumNameConverter(PartySetKind.values))();

  TextColumn get spec => text().nullable().map(const PartySetSpecConverter())();
}
