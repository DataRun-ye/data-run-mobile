import 'package:d_sdk/core/sync/model/sync_config.dart';
import 'package:d_sdk/core/sync/sync_logger.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

typedef FromJsonCallback<D> = D Function(Map<String, dynamic> data);

abstract class AbstractDatasource<D> {
  Future<List<Insertable<D>>> syncWithRemote({
    SyncConfig? options,
    ProgressCallback? progressCallback,
  });

  String get resourceName;

  String get resourcePath => '$resourceName?paged=false';

  @protected
  D mapRemoteItem(Map<String, dynamic> json);

  @protected
  dynamic extractId(Map<String, dynamic> json) => json['uid'];

  @protected
  Future<List<Map<String, dynamic>>> getOnlineRaw(
      {SyncConfig? options, Map<String, dynamic>? params});

  D fromApiJson(Map<String, dynamic> data, {ValueSerializer? serializer});
}
