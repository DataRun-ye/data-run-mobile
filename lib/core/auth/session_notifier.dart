// import 'package:d_sdk/core/exception/exception.dart';
// import 'package:d_sdk/core/user_session/user_session.dart';
// import 'package:datarunmobile/app/di/injection.dart';
// import 'package:datarunmobile/core/auth/auth_storage.dart';
// import 'package:datarunmobile/core/auth/token_refresher.dart';
// import 'package:datarunmobile/core/auth/token_string_extension.dart';
// import 'package:datarunmobile/core/database/user_db_session.dart';
// import 'package:datarunmobile/core/network/reactive_connectivity_service.dart';
// import 'package:get_it/get_it.dart';
//
// Future<UserSession?> initializeApp() async {
//   // Get last active user ID
//
//   UserSession userSession = await appLocator<AuthStorage>().getActiveSession();
//   // Load tokens securely
//   TokenPair tokenPair = await appLocator<AuthStorage>().getActiveUserToken();
//   final expiry = tokenPair.accessToken.expirationTime;
//   if (!tokenPair.accessToken.isAccessTokenValid) {
//     final isOnline = await appLocator<ConnectivityService>().isOnline;
//     throwIfNot(isOnline,
//         SessionExpiredException('No connection to refresh User Expired Token'));
//     tokenPair =
//         await appLocator<TokenRefresher>().refreshToken(userActiveUserId);
//   }
//
//   return UserDbSession(userId: userActiveUserId, tokens: tokenPair);
// }
