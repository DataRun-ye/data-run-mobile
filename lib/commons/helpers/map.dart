extension MapFilter<K, V> on Map<K, V> {
  /// Returns a new map containing all key-value pairs matching the given [predicate].
  ///
  /// The returned map preserves the entry iteration order of the original map.
  Map<K, V> filter(bool Function(MapEntry<K, V> entry) predicate) {
    final result = <K, V>{};
    for (final entry in entries) {
      if (predicate(entry)) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }
}
