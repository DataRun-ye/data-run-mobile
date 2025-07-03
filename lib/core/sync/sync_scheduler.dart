import 'package:datarunmobile/core/network/connectivy_service.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncScheduler {
  SyncScheduler(
      {required SyncMetadataRepository metadataRepo,
      required NetworkUtil connectivity})
      : _connectivity = connectivity,
        _metadataRepo = metadataRepo;

  final NetworkUtil _connectivity;
  final SyncMetadataRepository _metadataRepo;

  Future<bool> shouldSync() async {
    if (!await _connectivity.isOnline()) return false;
    final syncDone = _metadataRepo.isInitialSyncDone;
    if (!syncDone) return true;
    final lastSync = _metadataRepo.getLastSyncTimeMillis() ?? 0;
    final interval = _metadataRepo.getSyncInterval();
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    return (currentTime - lastSync) > interval.milliseconds;
  }
}
