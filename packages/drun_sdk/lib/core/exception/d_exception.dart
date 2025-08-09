/// Exception thrown when a connecting with the server throws an error
class DException implements Exception {
  /// Creates a new `FormatException` with an optional error [message].
  ///
  /// Optionally also supply the actual [cause] with the incorrect format,
  const DException([
    this.message = 'Exception',
    this.cause,
  ]);

  /// A message describing the format error.
  final String? message;

  /// The actual source input which caused the error.
  ///
  /// This is usually a [String], but can be other types too.
  /// If it is a string, parts of it may be included in the [toString] message.
  ///
  /// The source is `null` if omitted or unknown.
  final Object? cause;

  // final StackTrace? stackTrace;

  // final String? userMessage;

  @override
  String toString() {
    String description = message ?? '';

    Object? source = this.cause;
    if (source is String) {
      description += "(source: '${source.substring(0, 50)}')";
    }

    return description;
  }
}
