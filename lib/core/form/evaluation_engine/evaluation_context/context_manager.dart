import 'package:datarun/core/form/evaluation_engine/evaluation_context/evaluation_context.dart';

class ContextManager {
  ContextManager()
      : globalContext = EvaluationContext('Global'),
        contexts = {};
  final EvaluationContext globalContext;

  // by path
  final Map<String, EvaluationContext> contexts;

  /// Creates a new context with an optional parent
  EvaluationContext createContext(String fieldId, {String? parentName}) {
    EvaluationContext? parent =
        parentName != null ? contexts[parentName] : globalContext;
    var newContext = EvaluationContext(fieldId, parent: parent);
    contexts[fieldId] = newContext;
    return newContext;
  }

  /// Retrieves a context by name
  EvaluationContext? getContext(String path) {
    return contexts[path] ?? (path == 'Global' ? globalContext : null);
  }

  /// Resolves a value across contexts
  dynamic resolve(String key, String contextName) {
    return getContext(contextName)?.getValue(key);
  }
}

class CachedComputation<R extends Object> {
  final R Function() computation;

  WeakReference<R>? _cache;

  CachedComputation(this.computation);

  R get result {
    final cachedResult = _cache?.target;
    if (cachedResult != null) {
      return cachedResult;
    }

    final result = computation();

    // WeakReferences do not support nulls, bools, numbers, and strings.
    if (result is! bool && result is! num && result is! String) {
      _cache = WeakReference(result);
    }

    return result;
  }
}
//
// void main() {
//   var manager = ContextManager();
//   // final cached = CachedComputation(() => jsonDecode(someJsonSource) as Object);
//   // print(cached.result); // Executes computation.
//   // print(cached.result); // Most likely uses cache.
// }
