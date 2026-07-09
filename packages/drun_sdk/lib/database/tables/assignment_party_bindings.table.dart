import 'package:drift/drift.dart';

/// the Binding Table
/// @author Hamza Assada 15/01/2026
class AssignmentPartyBindings extends Table {
  @override
  String get tableName => 'assignment_party_bindings';

  /// Corresponds to the Binding UUID
  TextColumn get id => text()();

  TextColumn get assignmentId => text()();

  TextColumn get roleName => text()();

  /// Can be null for global roles
  TextColumn get vocabularyId => text().nullable()();

  TextColumn get partySetId => text()();

  TextColumn get principalType => text().nullable()();

  TextColumn get principalId => text().nullable()();

  TextColumn get combineMode => text().withDefault(const Constant('UNION'))();

  @override
  Set<Column> get primaryKey => {id};
}
