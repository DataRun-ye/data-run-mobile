import 'package:datarunmobile/core/sync_manager/sync_progress_event.dart';

class SyncResourceStatus {
  factory SyncResourceStatus.fromEvent(SyncProgressEvent event) {
    return SyncResourceStatus(
      name: event.resourceName,
      state: event.syncProgressState,
      percentage: event.percentage,
      completed: event.completed,
      message: event.message,
    );
  }

  SyncResourceStatus({
    required this.name,
    required this.state,
    required this.percentage,
    required this.completed,
    this.message,
  });

  final String name;
  final SyncProgressState state;
  final double percentage;
  final bool completed;
  final String? message;
}
