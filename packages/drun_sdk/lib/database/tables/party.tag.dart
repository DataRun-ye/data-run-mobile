import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'party_key_value_idx', columns: {#key, #value})
class PartyTag extends Table {
  @ReferenceName("tags")
  TextColumn get partyId => text().references(Parties, #id)();

  TextColumn get key => text()();

  TextColumn get value => text()();

  DateTimeColumn get lastModifiedDate =>
      dateTime().nullable().clientDefault(() => DateTime.now().toUtc())();

  DateTimeColumn get createdDate =>
      dateTime().nullable().clientDefault(() => DateTime.now().toUtc())();

  @override
  Set<Column<Object>> get primaryKey => {partyId, key};
}
