// class ExpressionService {
//   final ExpressionRegistry _registry;
//   final EvaluationContext _context;
//
//   dynamic evaluate(String expressionName) {
//     final expression = _registry.get(expressionName);
//     return expression.evaluate(_context);
//   }
//
//   void handleValueChange(String changedUid) {
//     final dependentExpressions = _dependencyGraph.getDependents(changedUid);
//     _evaluationQueue.addAll(dependentExpressions);
//   }
// }
