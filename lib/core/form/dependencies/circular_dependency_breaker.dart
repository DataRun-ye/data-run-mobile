// import 'package:xwidget_el/xwidget_el.dart';
//
// import 'circular_dependency_error.dart';
//
// class CircularDependencyBreaker {
//   final _evaluationStack = <String>[];
//
//   dynamic evaluateWithGuard(String fieldId, Expression expr) {
//     if (_evaluationStack.contains(fieldId)) {
//       throw CircularDependencyError(fieldId, _evaluationStack);
//     }
//     _evaluationStack.add(fieldId);
//     final result = expr.evaluate();
//     _evaluationStack.removeLast();
//     return result;
//   }
// }