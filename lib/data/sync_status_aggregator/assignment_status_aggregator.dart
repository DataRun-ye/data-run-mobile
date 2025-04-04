import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/sync_status_aggregator/sync_status_aggregator.dart';

class AssignmentSyncStatusAggregator implements SyncStatusAggregator {
  @override
  Future<Map<SyncStatus, int>> aggregate(String assignmentId) async {
    // Implementation for assignment aggregation
    // e.g., query your repository/service for counts based on assignmentId
    return {
      SyncStatus.TO_POST: 2,
      SyncStatus.TO_UPDATE: 2,
      SyncStatus.SYNCED: 5,
      SyncStatus.ERROR: 1,
    };
  }
}
