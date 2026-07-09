// /// Exception thrown when a connecting with the server throws an error
// class DException implements Exception {
//   /// Creates a new `FormatException` with an optional error [message].
//   ///
//   /// Optionally also supply the actual [source] with the incorrect format,
//   DException([this.message = '', this.source]);
//
//   /// A message describing the format error.
//   final String message;
//
//   /// The actual source input which caused the error.
//   ///
//   /// This is usually a [String], but can be other types too.
//   /// If it is a string, parts of it may be included in the [toString] message.
//   ///
//   /// The source is `null` if omitted or unknown.
//   final Object? source;
//
//   /// Returns a description of the format exception.
//   ///
//   /// The description always contains the [message].
//   ///
//   /// If [source] is present and is a string, the description will contain
//   /// (at least a part of) the source.
//   @override
//   String toString() {
//     String report = 'DException';
//     if ((message).isNotEmpty) {
//       report = '$report: $message';
//     }
//
//     Object? source = this.source;
//     if (source is String) {
//       if (source.length > 78) {
//         source = '${source.substring(0, 75)}...';
//       }
//       return '$report\n$source';
//     }
//
//     return report;
//   }
// }
