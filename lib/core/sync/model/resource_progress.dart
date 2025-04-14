import 'package:datarunmobile/core/sync/model/resource_state.dart';

/// Progress tracking for individual resources
class ResourceProgress {
  ResourceProgress({
    required this.resourceName,
    required this.state,
  }) : timestamp = DateTime.now();

  // Helper constructors
  factory ResourceProgress.starting(String name) =>
      ResourceProgress(resourceName: name, state: const ResourceStarting());

  factory ResourceProgress.success(String name, int itemDownloaded) =>
      ResourceProgress(
          resourceName: name, state: ResourceSucceeded(itemDownloaded));

  factory ResourceProgress.failure(String name, Object error) =>
      ResourceProgress(resourceName: name, state: ResourceFailed(error));
  final String resourceName;
  final ResourceState state;
  final DateTime timestamp;
}
