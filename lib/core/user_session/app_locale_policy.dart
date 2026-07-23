import 'package:flutter/widgets.dart';

abstract final class AppLocalePolicy {
  static const noExplicitPreference = 'NA';

  static Locale? explicitLocale(
    Object? storedLanguage,
    Iterable<Locale> supportedLocales,
  ) {
    final languageCode = _languageCode(storedLanguage);
    if (languageCode == null) {
      return null;
    }
    return _matchingLocale(languageCode, supportedLocales);
  }

  static Locale resolveDeviceOrFallback({
    required List<Locale>? deviceLocales,
    required Iterable<Locale> supportedLocales,
    required String buildFallbackLanguage,
  }) {
    final supported = supportedLocales.toList(growable: false);
    if (supported.isEmpty) {
      throw StateError('At least one application locale must be supported');
    }

    for (final deviceLocale in deviceLocales ?? const <Locale>[]) {
      final match = _matchingLocale(deviceLocale.languageCode, supported);
      if (match != null) {
        return match;
      }
    }

    return _matchingLocale(buildFallbackLanguage, supported) ??
        _matchingLocale('ar', supported) ??
        supported.first;
  }

  static Locale? _matchingLocale(
    Object? language,
    Iterable<Locale> supportedLocales,
  ) {
    final languageCode = _languageCode(language);
    if (languageCode == null) {
      return null;
    }

    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode.toLowerCase() == languageCode) {
        return supportedLocale;
      }
    }
    return null;
  }

  static String? _languageCode(Object? language) {
    final value = language?.toString().trim().toLowerCase();
    if (value == null ||
        value.isEmpty ||
        value == noExplicitPreference.toLowerCase()) {
      return null;
    }
    return value.split(RegExp('[-_]')).first;
  }
}
