import 'package:d_sdk/database/converters/sync_error_list.converter.dart';
import 'package:drift/drift.dart';

class SyncSummaries extends Table {
  /// e.g. "activities", "teams"
  TextColumn get entity => text()();

  DateTimeColumn get lastSync => dateTime().withDefault(currentDateAndTime)();

  IntColumn get successCount => integer().withDefault(const Constant(0))();

  IntColumn get failureCount => integer().withDefault(const Constant(0))();

  /// JSON‑encoded list of errors
  TextColumn get errors => text().map(const SyncErrorListConverter())
      .nullable()();

  @override
  Set<Column<Object>> get primaryKey => {entity};
}
