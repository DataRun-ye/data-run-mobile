// import 'package:expression_language/expression_language.dart';
//
// /// standard arithmetic and logical operations
// dynamic calculate1() {
//   var expressionGrammarDefinition = ExpressionGrammarParser({});
//   var parser = expressionGrammarDefinition.build();
//
//   // Parse the expression
//   var result = parser.parse('contains("Hello, World!", "World")');
//
//   // The expression now contains a strongly typed expression tree
//   var expression = result.value as Expression<bool>;
//
//   // Evaluate the expression
//   bool value = expression.evaluate();
//   return value;
// }
//
// /// perform various string operations, such as concatenation and
// /// checking for substrings
// dynamic calculate2() {
//   var expressionGrammarDefinition = ExpressionGrammarParser({});
//   var parser = expressionGrammarDefinition.build();
//
//   // Parse the expression
//   var result = parser.parse('contains("Hello, World!", "World")');
//
//   // The expression now contains a strongly typed expression tree
//   var expression = result.value as Expression<bool>;
//
//   // Evaluate the expression
//   bool value = expression.evaluate();
//   // print('string operations, value: $value'); // Output: true
//   return value;
// }
//
// /// date and time operations
// dynamic calculate3() {
//   var expressionGrammarDefinition = ExpressionGrammarParser({});
//   var parser = expressionGrammarDefinition.build();
//
//   // Parse the expression
//   var result = parser.parse('durationInDays(diffDateTime(dateTime("2025-02-02"), dateTime("2025-01-01")))');
//
//   // The expression now contains a strongly typed expression tree
//   var expression = result.value as Expression<Integer>;
//
//   // Evaluate the expression
//   Integer value = expression.evaluate();
//   return value.value;
// }
//
// /// custom expressions by extending the Expression<T> class.
// /// as an example, this creates a custom expression to repeat a
// /// string multiple times:
// dynamic calculate4() {
//   var expressionGrammarDefinition = ExpressionGrammarParser({},
//     customFunctionExpressionFactories: [
//       ExplicitFunctionExpressionFactory<String>(
//         name: 'repeat',
//         createFunctionExpression: (parameters) =>
//             StringRepeatExpression(parameters[0] as Expression<String>, parameters[1] as Expression<Integer>),
//         parametersLength: 2,
//       ),
//     ],
//   );
//   var parser = expressionGrammarDefinition.build();
//
//   // Parse the expression
//   var result = parser.parse('repeat("Hello", 3)');
//
//   // The expression now contains a strongly typed expression tree
//   var expression = result.value as Expression<String>;
//
//   // Evaluate the expression
//   String value = expression.evaluate();
//   // print(value); // Output: HelloHelloHello
//   return value;
// }
//
// void main() {
//   print('standard arithmetic: ${calculate1()}'); // Output: true
//   print('string operations: ${calculate2()}'); // Output: true
//   print('datetime operations: ${calculate3()}'); // Output: true
//   print('custom expressions: ${calculate4()}'); // Output: true
// }
//
// class StringRepeatExpression extends Expression<String> {
//   final Expression<String> value;
//   final Expression<Integer> count;
//
//   StringRepeatExpression(this.value, this.count);
//
//   @override
//   String evaluate() {
//     return value.evaluate() * count.evaluate().value;
//   }
//
//   @override
//   Expression<String> clone(Map<String, ExpressionProviderElement> elementMap) {
//     return StringRepeatExpression(value.clone(elementMap), count.clone(elementMap));
//   }
//
//   @override
//   List<Expression<dynamic>> getChildren() {
//     return [value, count];
//   }
// }
