import 'package:d_sdk/core/form/rule/rule_parse_extension.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/core/form/dependencies/dependency_matrix.dart';

class DependencyGraphBuilder {
  DependencyMatrix buildGraph(FormVersion fromTemplate) {
    DependencyMatrix graph = DependencyMatrix();
    fromTemplate.treeFields?.forEach((field) {
      graph.addRelationship(field.name!, [
        ...field.dependencies,
        ...field.calculationDependencies,
        ...field.filterDependencies
      ]);
    });
    return graph;
  }
}
