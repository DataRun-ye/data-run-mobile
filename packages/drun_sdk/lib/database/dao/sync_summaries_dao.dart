import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'sync_summaries_dao.g.dart';

@DriftAccessor(tables: [SyncSummaries])
class SyncSummariesDao extends DatabaseAccessor<AppDatabase>
    with _$SyncSummariesDaoMixin {
  SyncSummariesDao(AppDatabase db) : super(db);

  Future<void> upsertSummary(SyncSummary summary) =>
      into(syncSummaries).insertOnConflictUpdate(summary);
}
