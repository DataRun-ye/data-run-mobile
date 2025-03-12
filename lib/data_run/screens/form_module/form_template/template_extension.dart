import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:datarunmobile/data_run/screens/form_module/form_template/form_element_template.dart';

extension TemplateRuleDependencies on FormElementTemplate {
  IList<String> get dependencies {
    List<String> dependencySet = [];
    for (final rule in rules) {
      final ruleDependencies = rule.ruleAction.dependencies;
      dependencySet.addAll(ruleDependencies);
    }
    return dependencySet.toSet().toIList();
  }
}

extension TemplateFilterDependencies on FieldElementTemplate {
  /// from the choiceFilter expression
  List<String> get choicesDependencies {
    List<String> dependencyList = [];
    final fieldPattern = RegExp(r'#\{(.*?)\}');

    if (type.isSelectType) {
      if (this.choiceFilter != null) {
        final filterDependencies = fieldPattern
            .allMatches(choiceFilter!)
            .map((match) => match.group(1)!)
            .toList();
        dependencyList.addAll(filterDependencies);
      }

      return dependencyList.toSet().toList();
    }

    return [];
  }

  String? get evalChoiceFilterExpression =>
      choiceFilter?.replaceAll('#{', '').replaceAll('}', '');
}
