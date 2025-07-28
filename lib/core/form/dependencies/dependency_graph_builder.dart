import 'package:d_sdk/core/form/rule/rule_parse_extension.dart';
import 'package:datarunmobile/core/form/dependencies/dependency_matrix.dart';
import 'package:datarunmobile/data/form_template_repository.dart';

class DependencyGraphBuilder {
  DependencyMatrix buildGraph(FormTemplateRepository fromTemplate) {
    DependencyMatrix graph = DependencyMatrix();
    fromTemplate.rootsFlatLookupMap().values.forEach((field) {
      graph.addRelationship(field.name!, [
        ...field.dependencies,
        ...field.calculationDependencies,
        ...field.filterDependencies
      ]);
    });
    return graph;
  }
}
