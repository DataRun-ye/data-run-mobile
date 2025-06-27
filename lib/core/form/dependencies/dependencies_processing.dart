import 'dart:collection';
import 'dart:math' as math;

/// Returns the [transitive closure][] of [graph].
///
/// [transitive closure]: https://en.wikipedia.org/wiki/Transitive_closure
///
/// Interprets [graph] as a directed graph with a vertex for each key and edges
/// from each key to the values that the key maps to.
///
/// Assumes that every vertex in the graph has a key to represent it, even if
/// that vertex has no outgoing edges. This isn't checked, but if it's not
/// satisfied, the function may crash or provide unexpected output. For example,
/// `{"a": ["b"]}` is not valid, but `{"a": ["b"], "b": []}` is.
Map<T, Set<T>> transitiveClosure<T>(Map<T, Iterable<T>> graph) {
  // This uses [Warshall's algorithm][], modified not to add a vertex from each
  // node to itself.
  //
  // [Warshall's algorithm]: https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm#Applications_and_generalizations.
  var result = <T, Set<T>>{};
  graph.forEach((vertex, edges) {
    result[vertex] = Set<T>.from(edges);
  });

  // Lists are faster to iterate than maps, so we create a list since we're
  // iterating repeatedly.
  var keys = graph.keys.toList();
  for (var vertex1 in keys) {
    for (var vertex2 in keys) {
      for (var vertex3 in keys) {
        if (result[vertex2]!.contains(vertex1) &&
            result[vertex1]!.contains(vertex3)) {
          result[vertex2]!.add(vertex3);
        }
      }
    }
  }

  return result;
}

/// Returns the [strongly connected components][] of [graph], in topological
/// order.
///
/// [strongly connected components]: https://en.wikipedia.org/wiki/Strongly_connected_component
///
/// Interprets [graph] as a directed graph with a vertex for each key and edges
/// from each key to the values that the key maps to.
///
/// Assumes that every vertex in the graph has a key to represent it, even if
/// that vertex has no outgoing edges. This isn't checked, but if it's not
/// satisfied, the function may crash or provide unexpected output. For example,
/// `{"a": ["b"]}` is not valid, but `{"a": ["b"], "b": []}` is.
List<Set<T>> stronglyConnectedComponents<T>(Map<T, Iterable<T>> graph) {
  // This uses [Tarjan's algorithm][].
  //
  // [Tarjan's algorithm]: https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm
  var index = 0;
  var stack = <T?>[];
  var result = <Set<T>>[];

  // The order of these doesn't matter, so we use un-linked implementations to
  // avoid unnecessary overhead.
  var indices = HashMap<T, int>();
  var lowLinks = HashMap<T, int>();
  var onStack = HashSet<T>();

  void strongConnect(T vertex) {
    indices[vertex] = index;
    lowLinks[vertex] = index;
    index++;

    stack.add(vertex);
    onStack.add(vertex);

    for (var successor in graph[vertex]!) {
      if (!indices.containsKey(successor)) {
        strongConnect(successor);
        lowLinks[vertex] = math.min(lowLinks[vertex]!, lowLinks[successor]!);
      } else if (onStack.contains(successor)) {
        lowLinks[vertex] = math.min(lowLinks[vertex]!, lowLinks[successor]!);
      }
    }

    if (lowLinks[vertex] == indices[vertex]) {
      var component = <T>{};
      T? neighbor;
      do {
        neighbor = stack.removeLast();
        onStack.remove(neighbor);
        component.add(neighbor as T);
      } while (neighbor != vertex);
      result.add(component);
    }
  }

  for (var vertex in graph.keys) {
    if (!indices.containsKey(vertex)) strongConnect(vertex);
  }

  // Tarjan's algorithm produces a reverse-topological sort, so we reverse it to
  // get a normal topological sort.
  return result.reversed.toList();
}

Map<T, Set<T>> buildReverseDependencyMap<T>(Map<T, Iterable<T>> dependencyMap) {
  // Invert the dependency graph
  final reverseDependencyMap = <T, Set<T>>{};
  dependencyMap.forEach((element, dependencies) {
    reverseDependencyMap.putIfAbsent(element, () => {});
    for (var dependency in dependencies) {
      reverseDependencyMap.putIfAbsent(dependency, () => {}).add(element);
    }
  });

  return reverseDependencyMap;
}

///////////////////////////////////////
// Map<T, Iterable<T>> stronglyConnectedDependencyMapr<T>(
//     Map<T, Iterable<T>> reverseDependencyMap) sync* {
//   final orderedElements = stronglyConnectedComponents(reverseDependencyMap);
//
//   for (var element in orderedElements) {
//     yield element.first;
//   }
// }

// /// yield the elements that need re-evaluation
// void propagateChange<T>(
//     T changedElement, Map<String, Iterable<T>> reverseDependencyMap) /*sync**/ {
//   final affectedElements = reverseDependencyMap[changedElement] ?? {};
//   final orderedIterator = dependencyOrderedIterator(reverseDependencyMap);
//
//   for (var element in orderedIterator) {
//     if (affectedElements.contains(element)) {
//       print('Evaluate: $element');
//     }
//   }
// }

/// Propagates changes from a given element using reverse dependencies.
///
/// Yields the affected elements in a breadth-first order, ensuring that no
/// element is visited more than once.
Iterable<T> propagateChange2<T>(
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
    'country': {'continent'},
    'continent': {},
    'transaction': {'warehouse', 'country'},
    'fieldE': {'transaction'},
    'fieldF': {'transaction', 'warehouse'},
  };

  // Build the reverse dependency map with transitive closure
  final reverseDependencyMap = buildReverseDependencyMap(dependencies2);

  final stronglyConnected = stronglyConnectedComponents(reverseDependencyMap);
  // print('stronglyConnected Components:');
  stronglyConnected.forEach((value) {
    // print('$value');
  });

  // final orderedIterator = dependencyOrderedIterator(reverseDependencyMap);
  // print('orderedIterator Components:');
  // orderedIterator.forEach((value) {
  //   print('$value');
  // });

  final changedElement = 'warehouse';
  // print('\n1- Propagating Changes to the effected elements:');
  // propagateChange(changedElement, reverseDependencyMap);

  // print('\n2- Propagating Changes to the effected elements: :');
  // for (var element in propagateChange2(changedElement, reverseDependencyMap)) {
  //   print('Evaluate: $element');
  // }
}

// temporarily for test
final dependencies2 = <String, Set<String>>{
  'country': <String>['continent', 'warehouse'].toSet(),
  'continent': <String>[].toSet(),
  'earth': <String>[].toSet(),
  'mars': <String>[].toSet(),
  'transaction': <String>['warehouse', 'country'].toSet(),
  'warehouse': <String>['continent'].toSet(),
  // This creates a circular dependency
  'fieldF': <String>['transaction', 'fieldE'].toSet(),
  'fieldE': <String>['transaction', 'fieldF'].toSet(),
};
