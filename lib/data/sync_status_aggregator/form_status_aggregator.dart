import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/sync_status_aggregator/sync_status_aggregator.dart';

class FormSyncStatusAggregator implements SyncStatusAggregator {
  @override
  Future<Map<SyncStatus, int>> aggregate(String formId) async {
    // Implementation for form aggregation
    return {
      SyncStatus.TO_POST: 2,
      SyncStatus.TO_UPDATE: 2,
      SyncStatus.SYNCED: 5,
      SyncStatus.ERROR: 1,
    };
  }
}
