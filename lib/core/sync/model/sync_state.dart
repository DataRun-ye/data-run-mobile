import 'package:datarunmobile/core/sync/model/resource_progress.data.dart';
import 'package:datarunmobile/core/sync/model/sync_status.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SyncState with EquatableMixin {
  SyncState({
    this.percentage = 0,
    this.totalResources = 0,
    this.status = SyncStatus.idle,
    this.currentResource,
    Iterable<ResourceProgress>? resourceHistory,
    this.lastSync,
    this.error,
  }) : this.resourceHistory = IList.orNull(resourceHistory) ?? IList();

  final double percentage;
  final int totalResources;
  final SyncStatus status;
  final ResourceProgress? currentResource;
  final IList<ResourceProgress> resourceHistory;
  final DateTime? lastSync;
  final Object? error;

  SyncState copyWith({
    double? percentage,
    int? totalResources,
    SyncStatus? status,
    ResourceProgress? currentResource,
    Iterable<ResourceProgress>? resourceHistory,
    DateTime? lastSync,
    Object? error,
  }) {
    return SyncState(
      percentage: percentage ?? this.percentage,
      status: status ?? this.status,
      totalResources: totalResources ?? this.totalResources,
      currentResource: currentResource ?? this.currentResource,
      resourceHistory: resourceHistory ?? this.resourceHistory,
      lastSync: lastSync ?? this.lastSync,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        percentage,
        totalResources,
        status,
        currentResource,
        resourceHistory,
        lastSync,
        error
      ];
}
