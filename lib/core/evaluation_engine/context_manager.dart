import 'package:datarun/core/evaluation_engine/evaluation_context.dart';

class ContextManager {
  ContextManager()
      : globalContext = EvaluationContext(name: 'Global'),
        contexts = {};
  final EvaluationContext globalContext;
  final Map<String, EvaluationContext> contexts;

  /// Creates a new context with an optional parent
  EvaluationContext createContext(String name, {String? parentName}) {
    EvaluationContext? parent = parentName != null ? contexts[parentName] : globalContext;
    var newContext = EvaluationContext(name: name, parent: parent);
    contexts[name] = newContext;
    return newContext;
  }

  /// Retrieves a context by name
  EvaluationContext? getContext(String name) {
    return contexts[name] ?? (name == 'Global' ? globalContext : null);
  }

  /// Resolves a value across contexts
  dynamic resolve(String key, String contextName) {
    return getContext(contextName)?.getValue(key);
  }
}

// void main() {
//   var manager = ContextManager();
//
//   // Create contexts
//   var contextA = manager.createContext('contextA');
//   var contextB = manager.createContext('contextB', parentName: 'contextA');
//
//   // Set values
//   contextA.setValue('field1', 100);
//   contextB.setValue('field3', 'field1 * 2', notify: false); // Expression
//
//   // Register dependency
//   contextA.registerDependency('field3', 'field1');
//
//   // Simulate update
//   print("Before Update: field3 = ${contextB.getValue('field3')}");
//   contextA.setValue('field1', 200); // Should trigger re-evaluation
//
//   print("After Update: field1 = ${contextB.getValue('field1')}");
//
// }
