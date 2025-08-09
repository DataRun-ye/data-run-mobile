import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'sync_summaries_dao.g.dart';

@DriftAccessor(tables: [SyncSummaries])
class SyncSummariesDao extends DatabaseAccessor<AppDatabase>
    with _$SyncSummariesDaoMixin {
  SyncSummariesDao(AppDatabase db) : super(db);

  /// Upsert the summary for one entity
  Future<void> upsertSummary(SyncSummary summary) =>
      into(syncSummaries).insertOnConflictUpdate(summary);

  /// Delete the old summary (if you ever need to clear everything)
  Future<void> clearAll() => delete(syncSummaries).go();

  /// Stream all summaries so your UI can rebuild
  Stream<List<SyncSummary>> watchAllSummaries() =>
      select(syncSummaries).watch();
}
