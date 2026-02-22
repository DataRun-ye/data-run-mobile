import 'package:d_sdk/database/tables/parties.table.dart';
import 'package:d_sdk/database/tables/party_sets.table.dart';
import 'package:drift/drift.dart';

class PartySetMembers extends Table {
  @ReferenceName("partySets")
  TextColumn get partySet => text().references(PartySets, #id,
      onUpdate: KeyAction.cascade, onDelete: KeyAction.cascade)();

  @ReferenceName("parties")
  TextColumn get Party => text().references(Parties, #id)();

  @override
  Set<Column<Object>> get primaryKey => {partySet, Party};
}
