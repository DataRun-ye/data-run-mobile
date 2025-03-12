import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:d2_remote/modules/datarun/form/shared/rule/rule_parse_extension.dart';
import 'package:datarunmobile/core/form/dependencies/dependency_matrix.dart';

class DependencyGraphBuilder {
  DependencyMatrix buildGraph(FormVersion fromTemplate) {
    DependencyMatrix graph = DependencyMatrix();
    fromTemplate.fields.forEach((field) {
      graph.addRelationship(field.name!, [
        ...field.dependencies,
        ...field.calculationDependencies,
        ...field.filterDependencies
      ]);
    });
    return graph;
  }
}
