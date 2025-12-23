import 'package:reactive_forms/reactive_forms.dart';

/// Validator that accepts Arabic + Latin letters (diacritics), common name
/// punctuation (apostrophe, hyphen, zero-width non-joiner), tolerates trailing
/// space, merges connectors (e.g. 'عبد', 'ibn', 'de', 'van') and requires
/// at least [minParts] name parts (default 4).
class ArEnFullNameValidator extends Validator<dynamic> {
  final int minParts;
  final int minLettersPerPart;

  const ArEnFullNameValidator({this.minParts = 4, this.minLettersPerPart = 2})
      : super();

  // Unicode-aware: \p{L} matches any kind of letter from any language.
  static final RegExp _validChars =
  RegExp(r"^[\p{L}\s'’\-\u200C]+$", unicode: true);

  static final Set<String> _connectors = {
    // Arabic connectors
    'عبد',
    'بن',
    'ابن',
    'آل',
    'أبو',
    'ابو',
    'أم',
    // Latin connectors (lowercase forms)
    'ibn',
    'bin',
    'binte',
    'binna',
    'de',
    'del',
    'da',
    'van',
    'von',
    'al'
  };

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final raw = (control.value ?? '').toString();

    // don't validate empty values here — let Validators.required enforce mandatory fields
    if (raw.trim().isEmpty) return null;

    // quick character whitelist: letters, spaces, apostrophes, hyphens, ZWNJ
    if (!_validChars.hasMatch(raw)) {
      // return a keyed error so you can map messages. The value can be a short reason.
      return <String, dynamic>{'fullName': 'invalidCharacters'};
    }

    // Normalize whitespace (collapse runs into single space), then trim.
    final normalized = raw.replaceAll(RegExp(r'\s+'), ' ').trim();

    // Split tokens and merge connectors with the following token
    final tokens = normalized.split(' ');
    final merged = <String>[];
    for (int i = 0; i < tokens.length; i++) {
      final t = tokens[i];
      final tLower = t.toLowerCase();

      if (_connectors.contains(t) || _connectors.contains(tLower)) {
        if (i + 1 < tokens.length) {
          merged.add('$t ${tokens[i + 1]}');
          i++; // skip the next token because it's merged
          continue;
        } else {
          // connector at end — accept it as-is (rare)
          merged.add(t);
          continue;
        }
      }

      merged.add(t);
    }

    // Count only parts that have at least minLettersPerPart characters (ignoring internal spaces)
    final validParts = merged.where(
          (p) => p.replaceAll(RegExp(r'\s+'), '').length >= minLettersPerPart,
    );

    if (validParts.length < minParts) {
      return <String, dynamic>{'fullName': 'tooFewParts'};
    }

    // valid
    return null;
  }
}
