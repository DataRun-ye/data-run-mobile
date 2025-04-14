import 'package:datarunmobile/core/sync/model/sync_status.dart';

/// Overall sync progress state
class SyncProgress {
  const SyncProgress._({
    required this.status,
    this.percentage = 0,
    this.totalResources = 0,
    this.error,
  });

  // Factory constructors
  factory SyncProgress.idle() => const SyncProgress._(status: SyncStatus.idle);

  factory SyncProgress.starting(int totalResources) => SyncProgress._(
      status: SyncStatus.starting, totalResources: totalResources);

  factory SyncProgress.running(double percentage) =>
      SyncProgress._(status: SyncStatus.running, percentage: percentage);

  factory SyncProgress.complete() =>
      const SyncProgress._(status: SyncStatus.complete, percentage: 100);

  factory SyncProgress.failed(Object error) =>
      SyncProgress._(status: SyncStatus.failed, error: error);
  final SyncStatus status;
  final double percentage;
  final int totalResources;
  final Object? error;
}
