import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/tables/form_templates.table.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

@TableIndex(name: 'template_version_number_idx', columns: {#versionNumber})
@TableIndex(name: 'template_version_template_idx', columns: {#template})
class FormTemplateVersions extends Table {
  TextColumn get id => text()();

  @ReferenceName("versions")
  TextColumn get template => text().references(FormTemplates, #id)();

  IntColumn get versionNumber => integer()();

  TextColumn get fields => text().map(const TemplateListConverter())();

  TextColumn get sections => text().map(const TemplateListConverter())();

  TextColumn get options => text().nullable().map(const FormOptionListConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
