import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/sync_status_aggregator/sync_status_aggregator_factory.dart';
import 'package:injectable/injectable.dart';

enum AggregationLevel { Assignment, Form }

@Injectable()
abstract class SyncStatusAggregator {
  @factoryMethod
  factory SyncStatusAggregator.create(
          {@factoryParam AggregationLevel? level}) =>
      SyncStatusAggregatorFactory.getAggregator(level!);

  Future<Map<SyncStatus, int>> aggregate(String id);
}
