import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';
import 'package:ulid/ulid.dart';

@TableIndex(name: 'repeat_template_path_idx', columns: {#templatePath})
class RepeatInstances extends Table with BaseTableMixin {
  TextColumn get id => text().withDefault(Constant(Ulid().toCanonical()))();

  TextColumn get submission => text().references(DataInstances, #id)();

  /// reference to nearest parent RepeatInstance (nullable)
  TextColumn get parent => text().references(RepeatInstances, #id).nullable()();

  /// Path of the Repeat in the FormTemplate (non-null)
  TextColumn get repeatPath => text()();

  /// Repeat index for order and identity (non-null)
  IntColumn get repeatIndex => integer()();

  BoolColumn get deleted => boolean().withDefault(Constant(false))();

  DateTimeColumn get clientUpdatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
