import 'package:d_sdk/datasource/datasource.dart';
import 'package:datarunmobile/core/sync/sync_progress_notifier.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

@injectable
class SyncExecutor {
  SyncExecutor({required SyncProgressNotifier progressNotifier})
      : _progressNotifier = progressNotifier,
        _dataSources = IMap.fromIterable(
            appLocator.getAll<AbstractDatasource<dynamic>>(fromAllScopes: true),
            keyMapper: (dataSource) => dataSource.resourceName,
            valueMapper: (dataSource) => dataSource);

  final SyncProgressNotifier _progressNotifier;
  final IMap<String, AbstractDatasource<dynamic>> _dataSources;

  int get resourcesToSync => _dataSources.values.length;

  Future<void> performSync() async {
    await _progressNotifier.wrapOperation(
      totalResources: _dataSources.length,
      operation: () async {
        for (final source in _dataSources.values) {
          await _progressNotifier.trackResource(source.resourceName, () {
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
