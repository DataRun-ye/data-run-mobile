import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/db_factory/database_factory.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:datarunmobile/core/auth/token_refresher.dart';
import 'package:datarunmobile/core/auth/token_string_extension.dart';
import 'package:datarunmobile/core/database/user_db_session.dart';
import 'package:datarunmobile/core/network/connectivy_service.dart';
import 'package:get_it/get_it.dart';

Future<UserDbSession?> initializeApp() async {
  late String userActiveUserId;
  late TokenPair tokenPair;
  try {
    // Get last active user ID
    userActiveUserId = appLocator<AuthStorage>().getActiveUserId();
    // Load tokens securely
    tokenPair = await appLocator<AuthStorage>().getActiveUserToken();
    final expiry = tokenPair.accessToken.expirationTime;
    if (!tokenPair.accessToken.isAccessTokenValid) {
      final isOnline = await appLocator<NetworkUtil>().isOnline();
      throwIfNot(
          isOnline,
          SessionExpiredException(
              'No connection to refresh User Expired Token'));
      tokenPair =
          await appLocator<TokenRefresher>().refreshToken(userActiveUserId);
    }
  } catch (e) {
    logDebug('Initializing App, no previous active user', source: e);
    return null;
  }

  // Initialize database
  final db = await appLocator<DatabaseFactory>().openForUser(userActiveUserId);

  return UserDbSession(
      userId: userActiveUserId,
      database: AppDatabase(
        executor: db,
        userId: userActiveUserId,
      ),
      tokens: tokenPair);
}
