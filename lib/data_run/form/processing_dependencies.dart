import 'dart:collection';

/// Computes the [transitive closure][] of a dependency graph.
///
/// The input graph represents a directed graph where keys are nodes, and the values
/// are the nodes they depend on (edges).
///
/// [transitive closure]: https://en.wikipedia.org/wiki/Transitive_closure
Map<T, Set<T>> transitiveClosure<T>(Map<T, Iterable<T>> graph) {
  // Initialize the result map with the direct dependencies
  final result = <T, Set<T>>{
    for (var node in graph.keys) node: Set<T>.from(graph[node] ?? <T>[]),
  };

  // Warshall's Algorithm: Compute transitive closure
  for (var intermediate in graph.keys) {
    for (var source in graph.keys) {
      if (result[source]!.contains(intermediate)) {
        result[source]!.addAll(result[intermediate]!);
      }
    }
  }

  return result;
}

/// Builds a reverse dependency map and computes its transitive closure.
///
/// A reverse dependency map shows, for each node, all the nodes that depend on it.
Map<T, Set<T>> buildTransitiveReverseDependencyMap<T>(
    Map<T, Iterable<T>> dependencyMap) {
  final reverseDependencyMap = <T, Set<T>>{};

  // Invert the dependency map
  for (var dependent in dependencyMap.keys) {
    reverseDependencyMap.putIfAbsent(dependent, () => {});
    for (var dependency in dependencyMap[dependent] ?? <T>[]) {
      reverseDependencyMap.putIfAbsent(dependency, () => {}).add(dependent);
    }
  }

  // Compute the transitive closure of the reverse dependencies
  return transitiveClosure(reverseDependencyMap);
}

/// Propagates changes from a given element using reverse dependencies.
///
/// Yields the affected elements in a breadth-first order, ensuring that no
/// element is visited more than once.
Iterable<T> propagateChange<T>(
    T changedElement, Map<T, Set<T>> reverseDependencyMap) sync* {
  final queue = Queue<T>()..add(changedElement);
  final visited = <T>{};

  while (queue.isNotEmpty) {
    final element = queue.removeFirst();

    // Check for circular dependencies (optional enhancement)
    if (visited.contains(element)) {
      continue; // Skip already visited elements
    }

    visited.add(element);
    yield element;

    // Add direct dependents to the queue
    for (var dependent in reverseDependencyMap[element] ?? <T>[]) {
      if (!visited.contains(dependent)) {
        queue.add(dependent);
      }
    }
  }
}

void main() {
  // Define a dependency graph
  final dependencies = <String, Set<String>>{
    'warehouse': {'country'},
    'country': {'continent', 'transaction'},
    'continent': {},
    'transaction': {'warehouse', 'country'},
    'fieldE': {'fieldF'},
    'fieldF': {'transaction'},
  };

  // Build the reverse dependency map with transitive closure
  final reverseDependencyMap =
  buildTransitiveReverseDependencyMap(dependencies);

  print(reverseDependencyMap);
  reverseDependencyMap.forEach((key, value) {
  });

  // for (var element in propagateChange('transaction', reverseDependencyMap)) {
  // }
}
