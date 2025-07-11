import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/use_cases/logout_strategies/logout_strategy.dart';

abstract class AuthManager {
  Future<bool> isAuthenticated();

  Future<User> login({required String username, required String password});

  Future<bool> clearUserSession({LogoutStrategy strategy});
}
