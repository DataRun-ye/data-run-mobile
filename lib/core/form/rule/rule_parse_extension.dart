import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/template.dart';
import 'package:datarunmobile/core/form/rule/action.dart';

extension FieldTemplateDependencies on Template {
  List<String> get dependencies {
    List<String> dependencySet = [];
    for (final rule in rules?.unlockView ?? []) {
      final ruleDependencies = rule.ruleAction.dependencies;
      dependencySet.addAll(ruleDependencies);
    }
    return dependencySet.toSet().toList();
  }

  List<String> get visibilityDependencies {
    List<String> dependencySet = [];
    for (final rule in (rules?.unlockView ?? [])
        .where((rule) => rule.ruleAction.action.isVisibility)) {
      final ruleDependencies = rule.ruleAction.dependencies;
      dependencySet.addAll(ruleDependencies);
    }
    return dependencySet.toSet().toList();
  }

  List<RuleAction> get visibilityRules {
    List<RuleAction> visibilityRules = [];
    for (final rule in (rules?.unlockView ?? [])
        .where((rule) => rule.ruleAction.action.isVisibility)) {
      visibilityRules.add(rule.ruleAction);
    }
    return visibilityRules.toSet().toList();
  }

  List<String> get calculationDependencies {
    List<String> dependencyList = [];
    final fieldPattern = RegExp(r'#\{(.*?)\}');

    if (type?.isCalculate == true) {
      if ((this as FieldTemplate).calculation != null &&
          (this as FieldTemplate).calculation!.isNotEmpty) {
        final calculationDependencies = fieldPattern
            .allMatches((this as FieldTemplate).calculation!)
            .map((match) => match.group(1)!)
            .toList();
        dependencyList.addAll(calculationDependencies);
      }

      return dependencyList.toSet().toList();
    }

    return [];
  }

  String? get calculationExpression {
    return (this as FieldTemplate)
        .calculation
        ?.replaceAll('#{', '')
        .replaceAll('}', '');
  }
}
