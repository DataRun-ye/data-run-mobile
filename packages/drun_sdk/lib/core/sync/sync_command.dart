import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/sync_error.dart';

/// ---------- Sync Commands & Events ----------
abstract class SyncCommand {}

class StartSync extends SyncCommand {
  final String resourceName;

  StartSync({required this.resourceName});
}

abstract class SyncEvent {}

class SyncInProgress extends SyncEvent {
  final String resourceName;
  final String? message;
  final SyncStage? stage;
  final double percentage;

  SyncInProgress(
      {required this.resourceName,
      this.percentage = 0,
      this.message,
      this.stage});

  SyncInProgress copyWith({
    String? resourceName,
    String? message,
    SyncStage? stage,
    double? percentage,
  }) {
    return SyncInProgress(
      resourceName: resourceName ?? this.resourceName,
      message: message ?? this.message,
      stage: stage ?? this.stage,
      percentage: percentage ?? this.percentage,
    );
  }
}

class SyncCompleted extends SyncEvent {
  // final int newVersion;
  final String resourceName;
  final SyncSummary syncSummary;

  SyncCompleted({required this.resourceName, required this.syncSummary});
}

class SyncFailed extends SyncEvent {
  // List<SyncError> errors;
  final Object? error;
  final String? message;

  SyncFailed({this.error, this.message});
}

class SyncTrigger {
  final String resourceName;
  final int? localVersion;
  final DateTime? lastSync;

  SyncTrigger({this.localVersion, required this.resourceName, this.lastSync});
}

abstract class FetchAction {
  final String? resourceName;

  FetchAction({this.resourceName});
}

class SnapshotFetch extends FetchAction {
  SnapshotFetch({required String resourceName})
      : super(resourceName: resourceName);
}

class DeltaFetch extends FetchAction {
  final int? since;

  DeltaFetch({required String resourceName, this.since})
      : super(resourceName: resourceName);
}

class NoOp extends FetchAction {}
