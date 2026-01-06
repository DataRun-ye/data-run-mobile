import 'package:d_sdk/core/form/rule/expression_provider.dart';
import 'package:d_sdk/database/shared/form_option.dart';
import 'package:expressions/src/expressions.dart';

class ChoiceFilter
    implements ExpressionProvider, EvaluationEngine<List<FormOption>> {
  final List<FormOption> options;
  final String? expression;

  const ChoiceFilter({required this.expression, this.options = const []});

  @override
  Expression getExpression() {
    return Expression.parse(expression!);
  }

  @override
  List<FormOption> evaluate([Map<String, dynamic>? context]) {
    List<FormOption> result = options;
    if (expression != null || options.any((o) => o.filterExpression != null)) {
      result = options
          .where((option) => evaluator.eval(
              option.filterExpression != null
                  ? Expression.parse(option.evalFilterExpression!)
                  : getExpression(),
              option.toContext()..addAll(context ?? {})))
          .toList();
    } else {
      return options;
    }

    return result;
    // return options;
  }

  ChoiceFilter copyWith({
    List<FormOption>? options,
    String? expression,
  }) {
    return ChoiceFilter(
      options: options ?? this.options,
      expression: expression ?? this.expression,
    );
  }
}
