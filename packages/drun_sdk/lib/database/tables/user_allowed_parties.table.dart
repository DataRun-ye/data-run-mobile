import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

class UserAllowedParties extends Table with BaseTableMixin, IdentifiableMixin {
  @override
  String get tableName => 'user_allowed_party';

  TextColumn get userId => text()();
  TextColumn get partyId => text().references(Parties, #id)();

  @override
  Set<Column> get primaryKey => {userId, partyId};
}
