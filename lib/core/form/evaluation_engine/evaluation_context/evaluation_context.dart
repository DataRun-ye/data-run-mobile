class EvaluationContext {
  EvaluationContext(this.fieldId,
      {this.parent,
      this.currentInstanceId,
      Map<String, dynamic>? initialValues})
      : values = initialValues ?? {};
  final String fieldId;
  final EvaluationContext? parent;
  final Map<String, dynamic> values;

  final String? currentInstanceId;

  /// Retrieves a value, checking parent contexts if necessary.
  dynamic getValue(String fieldId) {
    if (currentInstanceId == null) {
      if (values.containsKey(fieldId)) {
        return values[fieldId];
      }
    } else {
      // the repeat row's parent context, parent (the table) should not be null
      String compositeKey =
          _compositeFieldId(parent!.fieldId, currentInstanceId!, fieldId);
      if (values.containsKey(compositeKey)) {
        return values[compositeKey];
      }
    }

    // Recursively check parent
    return parent?.getValue(fieldId);
  }

  /// Sets a value and notifies dependents
  void setValue(
    String fieldId,
    dynamic value,
    /*{bool notify = true}*/
  ) {
    if (currentInstanceId != null) {
      // Construct the composite key.
      String compositeKey =
          _compositeFieldId(parent!.fieldId, currentInstanceId!, fieldId);
      values[compositeKey] = value;
      if (values.containsKey(compositeKey)) {
        return values[compositeKey];
      }
    }

    values[fieldId] = value;
    // if (notify) _notifyDependents(key);
  }

  String _compositeFieldId(
          String parentId, String instanceId, String fieldId) =>
      '$parentId.$currentInstanceId.$fieldId';
//
// /// Registers a dependency between fields
// void registerDependency(String dependent, String dependency) {
//   dependencies.putIfAbsent(dependency, () => []).add(dependent);
// }
//
// /// Notifies dependent fields of updates
// void _notifyDependents(String key) {
//   if (!dependencies.containsKey(key)) return;
//   for (var dependent in dependencies[key]!) {
//     // print('Field $dependent needs to be recomputed due to update in $key');
//     // Recompute logic (depends on expression evaluation system)
//   }
// }
}
