import 'package:d_sdk/datasource/abstract_datasource.dart';
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SyncExecutor {
  SyncExecutor(
      {required Iterable<AbstractDatasource<dynamic>> dataSources,
      required SyncProgressNotifier progressNotifier})
      : _dataSources = IMap.fromIterable(dataSources,
            keyMapper: (r) => r.apiResourceName, valueMapper: (r) => r),
        _progressNotifier = progressNotifier;

  final IMap<String, AbstractDatasource<dynamic>> _dataSources;
  final SyncProgressNotifier _progressNotifier;

  Future<void> performSync() async {
    await _progressNotifier.wrapOperation(
      totalResources: _dataSources.length,
      operation: () async {
        for (final source in _dataSources.values) {
          await _progressNotifier.trackResource(source.apiResourceName, () {
            return source.syncWithRemote();
          });
        }
      },
    );
  }

  Future<void> performResourceSync(String resourceName) async {
    await _progressNotifier.trackResource(resourceName, () async {
      return await _dataSources[resourceName]?.syncWithRemote() ?? [];
    });
  }
}
