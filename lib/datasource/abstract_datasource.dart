import 'package:datarunmobile/core/sync/model/sync_config.dart';
import 'package:datarunmobile/core/sync/sync_logger.dart';
import 'package:drift/drift.dart';

abstract class AbstractDatasource<D> {
  Future<List<Insertable<D>>> syncWithRemote({
    SyncConfig? options,
    ProgressCallback? progressCallback,
  });

  String get resourceName;

  String get resourcePath => '$resourceName?paged=false';
}
