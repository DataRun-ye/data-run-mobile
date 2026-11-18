import 'package:datarunmobile/core/util/latin_digits_input_formatter.dart';

/// Folds names for search, so spellings people use interchangeably match.
///
/// The Arabic rules follow Lucene's ArabicNormalizer: alef with hamza or madda
/// becomes alef, alef maksura becomes yeh, teh marbuta becomes heh, and
/// tatweel and harakat are dropped. On top of that: Persian yeh and keheh
/// become yeh and kaf, Arabic-Indic digits become 0-9, Latin letters are
/// lower-cased, and spaces and invisible marks are dropped, so "عبد الله"
/// matches "عبدالله".
abstract final class SearchFolding {
  static String fold(String value) {
    final folded = StringBuffer();
    final source = LatinDigitsInputFormatter.normalize(value).toLowerCase();
    for (final rune in source.runes) {
      final replacement = _fold(rune);
      if (replacement != null) folded.writeCharCode(replacement);
    }
    return folded.toString();
  }

  /// The folded words of [query]; empty when it has nothing to search for.
  static List<String> queryTerms(String query) => query
      .split(RegExp(r'\s+'))
      .map(fold)
      .where((term) => term.isNotEmpty)
      .toList(growable: false);

  /// Whether every term appears in [foldedName], in any order.
  static bool matches(String foldedName, List<String> terms) =>
      terms.every(foldedName.contains);

  static int? _fold(int rune) {
    switch (rune) {
      case 0x0622: // آ
      case 0x0623: // أ
      case 0x0625: // إ
      case 0x0671: // ٱ
        return 0x0627; // ا
      case 0x0649: // ى
      case 0x06CC: // ی
        return 0x064A; // ي
      case 0x0629: // ة
        return 0x0647; // ه
      case 0x06A9: // ک
        return 0x0643; // ك
      case 0x0640: // tatweel
      case 0x0670: // superscript alef
        return null;
    }
    if (rune >= 0x064B && rune <= 0x065F) return null; // harakat
    if (_isSpaceOrInvisible(rune)) return null;
    return rune;
  }

  static bool _isSpaceOrInvisible(int rune) =>
      rune == 0x20 ||
      (rune >= 0x09 && rune <= 0x0D) ||
      rune == 0xA0 ||
      (rune >= 0x2000 && rune <= 0x200F) ||
      rune == 0x202F ||
      rune == 0x2060 ||
      rune == 0xFEFF;
}
