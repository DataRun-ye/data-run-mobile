// import 'package:expression_language/expression_language.dart';
//
// class FormExpressionContext implements ExpressionProviderElement {
//   final Map<String, dynamic> values;
//   final String contextId;
//
//   FormExpressionContext(this.values, this.contextId);
//
//   @override
//   String? get id => contextId;
//
//   @override
//   FormExpressionContext clone(ExpressionProvider<ExpressionProviderElement> parent) {
//     // Clone the current context with the same values but a new reference
//     return FormExpressionContext(Map.from(values), contextId);
//   }
//
//   @override
//   ExpressionProvider getExpressionProvider([String? propertyName]) {
//     if (propertyName == null) {
//       // Return the full context as an ExpressionProvider
//       return MapExpressionProvider(values);
//     } else if (values.containsKey(propertyName)) {
//       // Return a provider for the specific property
//       return SingleValueExpressionProvider(values[propertyName]);
//     }
//     throw ArgumentError("Property $propertyName not found in context.");
//   }
// }
