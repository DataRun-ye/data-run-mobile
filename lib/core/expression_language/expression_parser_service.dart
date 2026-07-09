// class ExpressionParserService {
//   final ExpressionGrammarParser parser;
//
//   ExpressionParserService()
//       : parser = ExpressionGrammarParser({
//     "form": FormExpressionContext({}) // Default empty context
//   });
//
//   Expression<dynamic> parseExpression(String expressionStr) {
//     var result = parser.parse(expressionStr);
//     return result.value as Expression<dynamic>;
//   }
// }
