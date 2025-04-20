import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_parse_extension.dart';
import 'package:datarunmobile/data_run/form/processing_dependencies.dart';

class FormTreeService {
  Map<String, Set<String>> buildDependencyGraph(FormVersion root) {
    Map<String, Set<String>> graph = {};
    for (var element in root.formFlatFields.values) {
      graph[element.path] = element.dependencies.toSet();
    }
    final reverseDependencyGraph = buildTransitiveReverseDependencyMap(graph);
    return reverseDependencyGraph;
  }

  List<String> getAffectedElements(
      FormVersion root, String changedElementPath) {
    var graph = buildDependencyGraph(root);
    List<String> affected = [];
    for (var entry in graph.entries) {
      if (entry.value.contains(changedElementPath)) {
        affected.add(entry.key);
      }
    }
    return affected;
  }
}
