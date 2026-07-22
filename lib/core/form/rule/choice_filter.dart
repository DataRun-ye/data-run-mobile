import 'package:datarunmobile/core/form/rule/expression_provider.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:expressions/src/expressions.dart';

class ChoiceFilter
    implements
        DependenciesProvider,
        ExpressionProvider<List<FormOption>>,
        EvaluationEngine<List<FormOption>> {
  const ChoiceFilter({required this.expression, this.options = const []});

  final List<FormOption> options;
  final String? expression;

  bool get hasFilters =>
      expression != null ||
      options.any((option) => option.filterExpression != null);

  @override
  List<String> get dependencies {
    final fieldPattern = RegExp(r'#\{(.*?)\}');
    return {
      for (final filterExpression in [
        expression,
        ...options.map((option) => option.filterExpression),
      ].whereType<String>())
        ...fieldPattern
            .allMatches(filterExpression)
            .map((match) => match.group(1)!),
    }.toList();
  }

  @override
  Expression getExpression() {
    return Expression.parse(_evalExpression(expression!));
  }

  @override
  List<FormOption> evaluate([Map<String, dynamic>? context]) {
    if (!hasFilters) {
      return options;
    }

    return options.where((option) {
      final filterExpression = option.filterExpression ?? expression;
      if (filterExpression == null) {
        return true;
      }

      return evaluator.eval(
        Expression.parse(_evalExpression(filterExpression)),
        option.toContext()..addAll(context ?? {}),
      );
    }).toList();
  }

  String _evalExpression(String value) =>
      value.replaceAll('#{', '').replaceAll('}', '');
}
