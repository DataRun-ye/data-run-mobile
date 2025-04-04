import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/sync_status_aggregator/sync_status_aggregator.dart';
import 'package:stacked/stacked.dart';

class SyncBadgesViewModel extends FutureViewModel<Map<SyncStatus, int>> {
  SyncBadgesViewModel({required this.aggregationLevel, required this.id});

  final String id;
  final AggregationLevel aggregationLevel;
  late final SyncStatusAggregator aggregator =
      locator<SyncStatusAggregator>(param1: aggregationLevel);

  @override
  Future<Map<SyncStatus, int>> futureToRun() async =>
      await runBusyFuture(aggregator.aggregate(id));
}
