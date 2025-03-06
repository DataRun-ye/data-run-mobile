import 'package:datarun/core/form/evaluation_engine/evaluation_context/evaluation_context.dart';

class SmartCache {
  final Map<String, DependenciesCache> store = {};

  bool shouldRecompute(String target, EvaluationContext context) {
    return store[target]?.dependencies.any((f) {
          final dependencyCurrentValue = context.getValue(f);
          final dependencyCachedValue = store[target]?.getValue(f);
          final recompute = dependencyCurrentValue != dependencyCachedValue;
          if (recompute) {
            updateCache(target, f, dependencyCurrentValue);
          }
          return recompute;
        }) ??
        true;
  }

  void updateCache(String target, String dependency, dynamic value) {
    store.putIfAbsent(
        target, () => DependenciesCache()..addDependency(dependency, value));
  }
}

class DependenciesCache {
  /// snapshot of dependencies values
  final Map<String, dynamic> _snapshot = {};
  final Set<String> _dependencies = {};

  dynamic getValue(String dependency) {
    return _snapshot[dependency];
  }

  Set<String> get dependencies => Set.unmodifiable(_dependencies);

  void addDependency(String dependency, dynamic value) {
    _dependencies.add(dependency);
    _snapshot.update(dependency, (v) => value, ifAbsent: () => value);
  }
}
