/// State for individual resources
sealed class ResourceState {
  const ResourceState();
}

class ResourceStarting extends ResourceState {
  const ResourceStarting();
}

class ResourceSucceeded extends ResourceState {
  const ResourceSucceeded(this.itemsDownloaded);

  final int itemsDownloaded;
}

class ResourceFailed extends ResourceState {
  const ResourceFailed(this.error);

  final Object error;
}
