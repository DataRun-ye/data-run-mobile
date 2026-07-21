import 'package:expressions/expressions.dart';

abstract class ExpressionProvider<T> {
  Expression getExpression();
}

abstract class DependenciesProvider {
  List<String> get dependencies;
}

const evaluator = const ExpressionEvaluator();

abstract class EvaluationEngine<T> {
  T evaluate([Map<String, dynamic>? context]);
}
