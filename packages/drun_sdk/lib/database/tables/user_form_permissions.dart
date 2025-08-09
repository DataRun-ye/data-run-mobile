import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'form_permission_form_idx', columns: {#team, #form})
class UserFormPermissions extends Table {
  @ReferenceName("teamFormPermissions")
  TextColumn get team => text().references(Teams, #id)();

  @ReferenceName("formPermissions")
  TextColumn get form => text().references(FormTemplates, #id)();

  DateTimeColumn get validFrom => dateTime().nullable()();

  DateTimeColumn get validTo => dateTime().nullable()();

  TextColumn get permissions => text().map(const FormPermissionsConverter())();

  @override
  Set<Column> get primaryKey => {team, form};
}
