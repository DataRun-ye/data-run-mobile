import 'package:expressions/expressions.dart';
import 'package:datarun/commons/logging/new_app_logging.dart';

const evaluationEngine = const EvaluationEngine();

class EvaluationEngine {
  const EvaluationEngine() : evaluator = const ExpressionEvaluator();

  final ExpressionEvaluator evaluator;

  dynamic evaluateExpression(String expressionString, Map<String, dynamic> context) {
    try {
      Expression parsedExpression = Expression.parse(expressionString);
      var result = evaluator.eval(parsedExpression, context);
      return result;
    } catch (e) {
      // Handling evaluation errors (e.g invalid expression, missing variables).
      logError('Error evaluating expression: $e');
      return false;
    }
  }
}
