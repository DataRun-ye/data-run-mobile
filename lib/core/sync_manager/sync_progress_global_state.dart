import 'package:datarunmobile/core/sync/model/sync_progress_event.dart';

class SyncProgressGlobalState {
  factory SyncProgressGlobalState.initial({required int totalResources}) =>
      SyncProgressGlobalState(
        overallPercentage: 0,
        overallState: SyncProgressState.ENQUEUED,
        currentMessage: '',
        completedResources: 0,
        failedResources: 0,
        syncedItems: 0,
        totalResources: totalResources,
      );

  SyncProgressGlobalState({
    required this.overallPercentage,
    required this.overallState,
    required this.totalResources,
    this.completedResources,
    this.failedResources = 0,
    this.currentMessage,
    this.syncedItems,
    this.completed = false,
  });

  final double overallPercentage;
  final SyncProgressState overallState;
  final String? currentMessage;
  final int? syncedItems;
  final int? completedResources;
  final int failedResources;
  final int totalResources;
  final bool completed;

  SyncProgressGlobalState addSyncStatus(
      {SyncProgressState syncStatus = SyncProgressState.RUNNING,
      String? currentMessage,
      double? overallPercentage,
      int? completedResources,
      int? failedResources,
      int? syncedItems,
      bool completed = false}) {
    final nextCompleted = completedResources ?? this.completedResources ?? 0;
    final nextFailed = failedResources ?? this.failedResources;
    final isComplete = nextCompleted >= totalResources;
    final SyncProgressState newStatus;
    if (isComplete) {
      newStatus = nextFailed == 0
          ? SyncProgressState.SUCCEEDED
          : nextFailed >= totalResources
              ? SyncProgressState.FAILED
              : SyncProgressState.PARTIAL_ERROR;
    } else if (nextFailed > 0) {
      newStatus = SyncProgressState.PARTIAL_ERROR;
    } else {
      newStatus = syncStatus;
    }

    return copyWith(
      overallState: newStatus,
      overallPercentage: overallPercentage ?? this.overallPercentage,
      completedResources: nextCompleted,
      failedResources: nextFailed,
      syncedItems: (this.syncedItems ?? 0) + (syncedItems ?? 0),
      currentMessage: currentMessage,
      completed: isComplete,
    );
  }

  SyncProgressGlobalState copyWith(
      {double? overallPercentage,
      SyncProgressState? overallState,
      String? currentMessage,
      int? completedResources,
      int? failedResources,
      int? totalResources,
      int? syncedItems,
      bool? completed}) {
    return SyncProgressGlobalState(
        overallPercentage: overallPercentage ?? this.overallPercentage,
        overallState: overallState ?? this.overallState,
        currentMessage: currentMessage ?? this.currentMessage,
        completedResources: completedResources ?? this.completedResources,
        failedResources: failedResources ?? this.failedResources,
        totalResources: totalResources ?? this.totalResources,
        syncedItems: syncedItems ?? this.syncedItems,
        completed: completed ?? this.completed);
  }

// static SyncProgressGlobalState aggregate(List<SyncResourceStatus> states,
//     double percentage, String currentMessage) {
//   if (states.isEmpty) return SyncProgressGlobalState.initial();
//   //
//   // final totalPercentage =
//   //     states.map((s) => s.percentage).reduce((a, b) => a + b);
//   // final avgPercentage = totalPercentage / states.length;
//
//   final anyFailed = states.any((s) => s.state == SyncProgressState.FAILED);
//   final allComplete = states.every((s) => s.completed);
//
//   final overallState = anyFailed
//       ? SyncProgressState.FAILED
//       : allComplete
//           ? SyncProgressState.SUCCEEDED
//           : SyncProgressState.RUNNING;
//
//   return SyncProgressGlobalState(
//       percentage: percentage,
//       overallState: overallState,
//       currentMessage: currentMessage);
// }
}
