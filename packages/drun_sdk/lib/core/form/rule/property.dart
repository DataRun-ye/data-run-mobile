// import 'package:d_sdk/modules/datarun/form/shared/rule/expression_provider.dart';
// import 'package:meta/meta.dart';
// import 'package:rxdart/rxdart.dart';
//
//
// abstract class Property<T> implements ExpressionProvider {
//   T? _cachedValue;
//
//   T get value => _cachedValue ?? evaluate();
//
//   T evaluate(Map<String, dynamic> context) {
//     var oldValue = _cachedValue;
//
//     // context
//     final expression = getExpression();
//     Expression parsedExpression = Expression.parse(expressionString);
//     var result = evaluator.eval(parsedExpression, context);
//
//     _cachedValue = getExpression().evaluate();
//     if (_cachedValue != oldValue) {
//       valueChangedSubject?.add(_cachedValue);
//       notifySubscribers();
//     }
//     return _cachedValue!;
//   }
//
//
//   Stream<T> get valueChanged =>
//       (valueChangedSubject ??= BehaviorSubject<T>.seeded(value)) as Stream<T>;
//
//   @protected
//   BehaviorSubject<T?>? valueChangedSubject;
//
//   void addSubscriber(Property<dynamic> expressionProperty) {
//     subscribers.add(expressionProperty);
//   }
//
//   @protected
//   final Set<Property<dynamic>> subscribers = {};
//
//   @protected
//   void notifySubscribers() {
//     subscribers.forEach((s) => s.evaluate());
//   }
//
//   Property<T> clone();
// }
