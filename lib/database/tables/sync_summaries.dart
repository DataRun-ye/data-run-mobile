import 'package:datarunmobile/database/converters/sync_error_list.converter.dart';
import 'package:drift/drift.dart';

class SyncSummaries extends Table {
  /// e.g. "activities", "teams"
  /// resource key
  TextColumn get entity => text()();

  /// lastSyncAttempt
  DateTimeColumn get lastSync => dateTime().withDefault(currentDateAndTime)();

  IntColumn get successCount => integer().withDefault(const Constant(0))();

  IntColumn get failureCount => integer().withDefault(const Constant(0))();

  /// JSON‑encoded list of errors
  TextColumn get errors => text().map(const SyncErrorListConverter())
      .nullable()();

  DateTimeColumn get lastSuccessfulSync => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {entity};
}
