import 'package:datarunmobile/core/sync_manager/sync_progress_event.dart';
import 'package:datarunmobile/core/sync_manager/sync_resource_status.dart';

class SyncProgressGlobalState {

  factory SyncProgressGlobalState.initial() => SyncProgressGlobalState(
      percentage: 0, overallState: SyncProgressState.ENQUEUED);

  SyncProgressGlobalState({
    required this.percentage,
    required this.overallState,
    this.currentMessage,
  });
  final double percentage;
  final SyncProgressState overallState;
  final String? currentMessage;

  static SyncProgressGlobalState aggregate(List<SyncResourceStatus> states) {
    if (states.isEmpty) return SyncProgressGlobalState.initial();

    final totalPercentage =
        states.map((s) => s.percentage).reduce((a, b) => a + b);
    final avgPercentage = totalPercentage / states.length;

    final anyFailed = states.any((s) => s.state == SyncProgressState.FAILED);
    final allComplete = states.every((s) => s.completed);

    final overallState = anyFailed
        ? SyncProgressState.FAILED
        : allComplete
            ? SyncProgressState.SUCCEEDED
            : SyncProgressState.RUNNING;

    return SyncProgressGlobalState(
      percentage: avgPercentage,
      overallState: overallState,
    );
  }
}
