import 'package:datarunmobile/data/sync_status_aggregator/assignment_status_aggregator.dart';
import 'package:datarunmobile/data/sync_status_aggregator/form_status_aggregator.dart';
import 'package:datarunmobile/data/sync_status_aggregator/sync_status_aggregator.dart';

class SyncStatusAggregatorFactory {
  static SyncStatusAggregator getAggregator(AggregationLevel level) {
    switch (level) {
      case AggregationLevel.Assignment:
        return AssignmentSyncStatusAggregator();
      case AggregationLevel.Form:
        return FormSyncStatusAggregator();
      default:
        throw UnimplementedError('Aggregator for $level is not implemented');
    }
  }
}
