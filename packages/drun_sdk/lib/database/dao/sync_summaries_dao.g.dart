// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_summaries_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncSummariesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncSummariesTable get syncSummaries => attachedDatabase.syncSummaries;
  SyncSummariesDaoManager get managers => SyncSummariesDaoManager(this);
}

class SyncSummariesDaoManager {
  final _$SyncSummariesDaoMixin _db;
  SyncSummariesDaoManager(this._db);
  $$SyncSummariesTableTableManager get syncSummaries =>
      $$SyncSummariesTableTableManager(_db.attachedDatabase, _db.syncSummaries);
}
