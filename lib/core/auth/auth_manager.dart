import 'package:d_sdk/database/app_database.dart';
import 'package:flutter/material.dart';

abstract class AuthManager extends ChangeNotifier {
  bool isAuthenticated();

  Future<User> login({required String username, required String password});

  // Future<bool> clearUserSession({LogoutStrategy strategy});

  Future<void> checkAuthStatus();

  Future<void> logout();

  AuthStatus get status;

  User? get currentUser;
}

/// Enum to represent the authentication status of the user.
enum AuthStatus {
  unknown, // Initial state, checking authentication
  unauthenticated, // User is not logged in
  authenticated, // User is logged in
}
