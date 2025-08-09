import 'package:d_sdk/core/form/rule/expression_provider.dart';
import 'package:expressions/src/expressions.dart';

class CalculatedExpression
    implements ExpressionProvider, EvaluationEngine<dynamic> {
  final String expression;

  const CalculatedExpression({required this.expression});

  @override
  Expression getExpression() {
    return Expression.parse(expression);
  }

  @override
  dynamic evaluate([Map<String, dynamic>? context]) {
    return evaluator.eval(getExpression(), context ?? {});
  }
}
