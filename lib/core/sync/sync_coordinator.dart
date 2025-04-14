import 'package:d_sdk/datasource/datasource.dart';
import 'package:d_sdk/di/injection.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/core/sync/sync_executor.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart';
import 'package:datarunmobile/core/sync/sync_scheduler.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncCoordinator {
  SyncCoordinator(
    this._metadataRepo,
    this._scheduler,
    SyncProgressNotifier progressNotifier,
  ) : this._executor = SyncExecutor(
            dataSources: appLocator.getAll<AbstractDatasource<dynamic>>(),
            progressNotifier: progressNotifier);

  final SyncMetadataRepository _metadataRepo;
  final SyncScheduler _scheduler;
  final SyncExecutor _executor;

  Future<void> handleSyncLifecycle() async {
    if (await _scheduler.shouldSync()) {
      await _executor.performSync();
      await _metadataRepo.updateLastSync();
    }
  }

  Future<void> handleResourceSyncLifecycle(String resourceName) async {
    await _executor.performResourceSync(resourceName);
  }
}
