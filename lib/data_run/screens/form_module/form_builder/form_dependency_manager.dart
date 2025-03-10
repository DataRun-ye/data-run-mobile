import 'package:datarun/data_run/screens/form_module/form_template/form_element_template.dart';
import 'package:datarun/data_run/screens/form_module/form_template/template_extension.dart';
import 'package:datarun/data_run/form/processing_dependencies.dart';

class FormDependencyManager {
  FormDependencyManager({required this.formFlatTemplate});

  late Map<String, List<String>> _dependencyGraph;
  late Map<String, Set<String>> _reverseDependencyGraph;
  final FormFlatTemplate formFlatTemplate;

  void initializeGraph() {
    _dependencyGraph = formFlatTemplate.flatFields.map(
        (path, FormElementTemplate field) =>
            MapEntry(path, buildDependencyGraph(field)));

    _reverseDependencyGraph =
        buildTransitiveReverseDependencyMap(_dependencyGraph);
  }

  List<String> buildDependencyGraph(FormElementTemplate element) {
    final dependenciesPaths = <String>[];
    for (var dependency in element.dependencies) {
      final dependencyPath =
          formFlatTemplate.getScopedDependencyByName(dependency, element.path!);
      if (dependencyPath != null) {
        dependenciesPaths.add(dependencyPath.path!);
      }
    }
    return dependenciesPaths;
  }

  /// returns an Iterator of affected elements paths
  Iterable<String> propagateElementChange(String elementPath) {
    return propagateChange(elementPath, _reverseDependencyGraph);
  }
}
