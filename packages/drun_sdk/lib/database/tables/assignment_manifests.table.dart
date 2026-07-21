import 'package:d_sdk/database/converters/assignment_binding_list.converter.dart';
import 'package:d_sdk/database/converters/list.converter.dart';
import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:drift/drift.dart';

/// The "Manifest": Everything the client needs to initialize
/// a context.
///
/// @author Hamza Assada 15/01/2026
class AssignmentManifests extends Table {
  /// assignmentUid
  TextColumn get id => text()();

  TextColumn get name => text().nullable()();

  TextColumn get status =>
      text().map(const EnumNameConverter(AssignmentStatus.values)).nullable()();

  /// allowedTemplateUids
  TextColumn get templateUids => text().map(const ListConverter<String>())();

  TextColumn get bindings =>
      text().nullable().map(const AssignmentBindingListConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
