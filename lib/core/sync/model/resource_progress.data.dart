import 'package:datarunmobile/core/sync/model/resource_state.dart';

/// Progress tracking for individual resources
class ResourceProgress {
  ResourceProgress({
    required this.resourceName,
    required this.state,
    this.currentProgress = 0.0,
    this.weight = 1,
  }) : timestamp = DateTime.now();

  // Helper constructors
  factory ResourceProgress.starting(String name, {double weight = 1}) =>
      ResourceProgress(
          resourceName: name, state: const ResourceStarting(), weight: weight);

  factory ResourceProgress.success(String name, int itemDownloaded,
          {double weight = 1}) =>
      ResourceProgress(
          resourceName: name,
          state: ResourceSucceeded(itemDownloaded),
          currentProgress: 100.0);

  factory ResourceProgress.failure(String name, Object error,
          {double weight = 1}) =>
      ResourceProgress(resourceName: name, state: ResourceFailed(error));
  final String resourceName;
  final ResourceState state;
  final double currentProgress;
  final double weight;
  final DateTime timestamp;

  ResourceProgress copyWith({
    String? resourceName,
    ResourceState? state,
    double? currentProgress,
    double? weight,
  }) {
    return ResourceProgress(
      resourceName: resourceName ?? this.resourceName,
      state: state ?? this.state,
      currentProgress: currentProgress ?? this.currentProgress,
      weight: weight ?? this.weight,
    );
  }
}
