/// **dependency graph:**
///
/// maps relationships between fields so that when one field changes,
/// only the affected dependents are re-evaluated. The graph must also
/// detect cycles to prevent infinite loops.
class DependencyMatrix {
  /// Maps a source field to the set of fields that depend on it.
  final Map<String, Set<String>> forwardDependencies = {};

  /// Maps a field to the set of fields it depends on.
  final Map<String, Set<String>> reverseDependencies = {};

  /// Add dependency relationships between a source field and its dependents.
  void addRelationship(String source, List<String> dependents) {
    forwardDependencies.putIfAbsent(source, () => <String>{});
    for (final dependent in dependents) {
      forwardDependencies[source]!.add(dependent);
      reverseDependencies.putIfAbsent(dependent, () => <String>{});
      reverseDependencies[dependent]!.add(source);
    }
  }

  /// Retrieves all affected fields using a topological sort (Traverse
  /// forwardDependencies to collect all fields that depend
  /// (directly or indirectly)
  List<String> getAffectedFields(String changedFieldId) {
    final List<String> sorted = [];
    final Set<String> visited = {};
    void dfs(String field) {
      if (!visited.contains(field)) {
        visited.add(field);
        if (forwardDependencies.containsKey(field)) {
          for (final dependent in forwardDependencies[field]!) {
            dfs(dependent);
          }
        }
        sorted.add(field);
      }
    }

    dfs(changedFieldId);
    return sorted.reversed.toList();
  }
}

// import 'dart:collection';
//
// import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
// import 'package:d2_remote/modules/datarun/form/shared/template_extensions/form_traverse_extension.dart';
// import 'package:datarunmobile/core/form/expression_evaluation/expression_quantum.dart';
// import 'package:datarunmobile/core/form/expression_evaluation/expression_type.dart';
//
// class DependencyTracker {
//   /// field dependencies
//   final Map<String, Set<String>> _fieldDependencies = {};
//
//   /// field dependents
//   /// source:targets
//   final Map<String, Set<ExpressionQuantum>> _reverseLookup = {};
//
//   // cache expression : result
//   final Map<String, dynamic> _reverseLookup = {};
//
//   final Map<String, dynamic> _reverseLookup = {};
//
// // Optionally, include metadata for each dependency (e.g., expression type, priority)
//   final Map<String, int> fieldPriority = {}; // Lower number = higher priority
//
//   void buildGraph(FormVersion schema) {
//     schema.formFlatFields.values.forEach((field) {
//       final dependencies =
//           ExpressionParser.extractFieldReferences(field.visibilityExpr);
//       dependencies.addAll(
//           ExpressionParser.extractFieldReferences(field.calculationExpr));
//       graph.addDependencies(field.id, dependencies);
//     });
//     graph.detectCycles(); // Throws on circular dependency
//   }
//
//   void addDependency(String source, String target, ExpressionType type) {
//     _fieldDependencies.putIfAbsent(source, () => {}).add(target);
//     _reverseLookup.putIfAbsent(target, () => {}).add(source);
//   }
// //
// // void addDependencies(String source, List<String> targets) {
// //   _fieldDependencies.putIfAbsent(source, () => {}).addAll(targets);
// //   targets.forEach((t) =>
// //       _reverseLookup.putIfAbsent(t, () => {}).add(source));
// // }
//
//   List<String> getImpactedFields(String changedField) {
//     final impacted = <String>[];
//     final queue = Queue<String>.from([changedField]);
//     while (queue.isNotEmpty) {
//       final current = queue.removeFirst();
//       impacted.add(current);
//       (_reverseLookup[current] ?? {}).forEach(queue.add);
//     }
//
//     // 2. Remove the source field if present
//     impacted.remove(changedField);
//
//     // 3. Optionally, sort affected fields:
//     //    a. First, group by strongly connected components.
//     //    b. Then, sort topologically within each group.
//     //    c. Finally, sort by assigned priority.
//     final affectedList = impacted.toList();
//     affectedList.sort((a, b) {
//       final priorityA = fieldPriority[a] ?? 100;
//       final priorityB = fieldPriority[b] ?? 100;
//       return priorityA.compareTo(priorityB);
//     });
//
//     return impacted;
//   }
// }
//
// class DependencyGraph {
//   final _dependencies = <String, Set<String>>{};
//   final _reverseLookup = <String, Set<String>>{};
//
//   void addDependency(String source, List<String> targets) {
//     _dependencies.putIfAbsent(source, () => {}).addAll(targets);
//     targets.forEach((t) => _reverseLookup.putIfAbsent(t, () => {}).add(source));
//   }
//
//   List<String> getImpactedFields(String changedField) {
//     final impacted = <String>[];
//     final queue = Queue<String>.from([changedField]);
//     while (queue.isNotEmpty) {
//       final current = queue.removeFirst();
//       impacted.add(current);
//       (_reverseLookup[current] ?? {}).forEach(queue.add);
//     }
//
//     // 2. Remove the source field if present
//     impacted.remove(changedField);
//
//     // 3. Optionally, sort affected fields:
//     //    a. First, group by strongly connected components.
//     //    b. Then, sort topologically within each group.
//     //    c. Finally, sort by assigned priority.
//     final affectedList = impacted.toList();
//     affectedList.sort((a, b) {
//       final priorityA = fieldPriority[a] ?? 100;
//       final priorityB = fieldPriority[b] ?? 100;
//       return priorityA.compareTo(priorityB);
//     });
//
//     return impacted;
//   }
// }
//
// class DependencyMatrix {
//   final Map<String, Set<String>> forwardDependencies = {};
//   final Map<String, Set<String>> reverseDependencies = {};
//
//   // do I sort and process and then add the strongly connected map key -> effected elements
//   // or I do It inside this method, or kind of both adding element by element, but how
//   // the steps would have to be
//   void addRelationship(String source, List<String> dependents) {
//     // Maintain bidirectional relationships
//     // Detect circular dependencies using Tarjan's algorithm
//   }
//
//   List<String> getAffectedFields(String changedFieldId) {
//     // 1. Traverse reverseDependencies to collect all fields that depend (directly or indirectly)
//     final affected = <String>{};
//     final queue = Queue<String>();
//     queue.add(changedFieldId);
//
//     while (queue.isNotEmpty) {
//       final field = queue.removeFirst();
//       if (affected.contains(field)) continue;
//       affected.add(field);
//       if (reverseDependencies.containsKey(field)) {
//         queue.addAll(reverseDependencies[field]!);
//       }
//     }
//
//     // 2. Remove the source field if present
//     affected.remove(changedFieldId);
//
//     // 3. Optionally, sort affected fields:
//     //    a. First, group by strongly connected components.
//     //    b. Then, sort topologically within each group.
//     //    c. Finally, sort by assigned priority.
//     final affectedList = affected.toList();
//     affectedList.sort((a, b) {
//       final priorityA = fieldPriority[a] ?? 100;
//       final priorityB = fieldPriority[b] ?? 100;
//       return priorityA.compareTo(priorityB);
//     });
//     return affectedList;
//   }
// }
