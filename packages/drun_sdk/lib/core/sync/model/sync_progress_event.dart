enum SyncProgressState {
  ENQUEUED,
  RUNNING,
  SUCCEEDED,
  FAILED,
  PARTIAL_ERROR,
  CANCELLED;

  bool get isSuccess => this == SUCCEEDED;

  bool get isRunning => this == RUNNING;

  bool get isFailed => this == FAILED;

  bool isFinished() {
    return this == SUCCEEDED || this == FAILED || this == CANCELLED;
  }
}

class SyncProgressEvent {
  final String resourceName;
  final SyncProgressState syncProgressState;
  final String message;
  final double percentage;
  final bool completed;
  final int? resources;

  const SyncProgressEvent(
      {required this.resourceName,
      required this.syncProgressState,
      required this.message,
      required this.percentage,
      this.completed = false,
      this.resources});

  Map<String, dynamic> toMap() {
    return {
      'resourceName': this.resourceName,
      'syncProgressState': this.syncProgressState.name,
      'percentage': this.percentage,
    };
  }

  SyncProgressEvent copyWith(
      {String? resourceName,
      SyncProgressState? syncProgressState,
      String? message,
      double? percentage,
      bool? completed,
      int? resources}) {
    return SyncProgressEvent(
      resourceName: this.resourceName,
      syncProgressState: syncProgressState ?? this.syncProgressState,
      message: message ?? this.message,
      percentage: percentage ?? this.percentage,
      completed: completed ?? this.completed,
      resources: resources ?? this.resources,
    );
  }
}
