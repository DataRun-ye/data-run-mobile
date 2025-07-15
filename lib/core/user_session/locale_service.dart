// services/locale_service.dart
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service to manage the current locale for the authenticated user.
/// This service will be registered within the GetIt user session scope.
class LocaleService extends ChangeNotifier {
  LocaleService(Locale? initialLocale) {
    _currentLocale = initialLocale;
    logDebug('LocaleService initialized with: $_currentLocale');
  }

  Locale? _currentLocale;

  Locale? get currentLocale => _currentLocale;

  /// Updates the current locale and notifies listeners.
  void setLocale(Locale newLocale) {
    if (_currentLocale != newLocale) {
      _currentLocale = newLocale;
      appLocator<SharedPreferences>()
          .setValue(Preference.language, newLocale.languageCode);
      logDebug('Locale updated to: $_currentLocale');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    logDebug('LocaleService disposed.');
    super.dispose();
  }
}
