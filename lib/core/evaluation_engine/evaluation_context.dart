class EvaluationContext {
  EvaluationContext(
      {required this.name, this.parent, Map<String, dynamic>? initialValues})
      : values = initialValues ?? {},
        dependencies = {};
  final String name;
  final EvaluationContext? parent;
  final Map<String, dynamic> values;
  final Map<String, List<String>> dependencies; // Tracks dependent fields

  /// Retrieves a value, checking parent contexts if necessary.
  dynamic getValue(String key) {
    if (values.containsKey(key)) {
      return values[key];
    }
    return parent?.getValue(key); // Recursively check parent
  }

  /// Sets a value and notifies dependents
  void setValue(String key, dynamic value, {bool notify = true}) {
    values[key] = value;
    if (notify) _notifyDependents(key);
  }

  /// Registers a dependency between fields
  void registerDependency(String dependent, String dependency) {
    dependencies.putIfAbsent(dependency, () => []).add(dependent);
  }

  /// Notifies dependent fields of updates
  void _notifyDependents(String key) {
    if (!dependencies.containsKey(key)) return;
    // for (var dependent in dependencies[key]!) {
    //   // print('Field $dependent needs to be recomputed due to update in $key');
    //   // Recompute logic (depends on expression evaluation system)
    // }
  }
}
