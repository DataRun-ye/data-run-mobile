import 'package:datarunmobile/core/sync/sync_executor.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncCoordinator {
  SyncCoordinator(
    this._metadataRepo,
    this._scheduler,
    this._executor,
  );

  final SyncMetadataRepository _metadataRepo;
  final SyncScheduler _scheduler;
  final SyncExecutor _executor;
  bool _isSyncing = false;

  Future<void> handleSyncLifecycle() async {
    // if (await _scheduler.shouldSync()) {
    if (_isSyncing) return;
    _isSyncing = true;
    await _executor.performSync();
    await _metadataRepo.updateLastSync();
    await _metadataRepo.updateInitialSyncDone(true);
    _isSyncing = false;
    // }
  }

  Future<void> handleResourceSyncLifecycle(String resourceName) async {
    await _executor.performResourceSync(resourceName);
  }
}
