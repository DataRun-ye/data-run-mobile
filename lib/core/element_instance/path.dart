class Path {
  Path(this.raw);

  final String raw;

  List<String> get segments => raw.split('.');

  int get depth => segments.length;

  String get lastSegment => segments.last;

  bool get isRoot => segments.length == 1;

  Path get parent {
    if (isRoot) throw Exception('No parent for a root path');
    return Path(segments.sublist(0, segments.length - 1).join('.'));
  }

  Path append(String segment) => Path('$raw.$segment');

  Path join(Path other) => Path('$raw.${other.raw}');

  bool isAncestorOf(Path descendant) {
    final mySegments = segments;
    final descendantSegments = descendant.segments;
    if (mySegments.length >= descendantSegments.length) return false;
    for (int i = 0; i < mySegments.length; i++) {
      if (mySegments[i] != descendantSegments[i]) return false;
    }
    return true;
  }

  Path normalize() {
    // Basic normalization: trim white spaces and remove extra dots.
    final cleaned = raw
        .split('.')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .join('.');
    return Path(cleaned);
  }

  @override
  String toString() => raw;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Path &&
          runtimeType == other.runtimeType &&
          normalize().raw == other.normalize().raw;

  @override
  int get hashCode => normalize().raw.hashCode;
}
