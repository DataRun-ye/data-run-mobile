// services/server_url_service.dart
import 'package:flutter/material.dart';

/// A service to manage the current server URL for the authenticated user.
/// This service will be registered within the GetIt user session scope.
class ServerUrlService extends ChangeNotifier {
  String? _currentUrl;

  String? get currentUrl => _currentUrl;

  ServerUrlService(String? initialUrl) {
    _currentUrl = initialUrl;
    debugPrint('ServerUrlService initialized with: $_currentUrl');
  }

  /// Updates the current server URL and notifies listeners.
  void setServerUrl(String newUrl) {
    if (_currentUrl != newUrl) {
      _currentUrl = newUrl;
      debugPrint('Server URL updated to: $_currentUrl');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    debugPrint('ServerUrlService disposed.');
    super.dispose();
  }
}