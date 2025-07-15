import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:equatable/equatable.dart';

class UserDbSession with EquatableMixin {
  UserDbSession(
      {required this.userId, required this.database, required this.tokens});

  final String userId;
  final AppDatabase database;
  final TokenPair tokens;

  UserDbSession copyWith({
    TokenPair? tokens,
  }) {
    return UserDbSession(
      userId: this.userId,
      database: this.database,
      tokens: tokens ?? this.tokens,
    );
  }

  @override
  List<Object?> get props => [userId, tokens];
}

// // Session manager
// final sessionManagerProvider =
//     StateNotifierProvider<SessionNotifier, UserDbSession?>(
//         (ref) => SessionNotifier());
//
// class SessionNotifier extends StateNotifier<UserDbSession?> {
//   final TokenStorage _storage = appLocator<TokenStorage>();
//
//   DatabaseFactory get databaseFactory => appLocator<DatabaseFactory>();
//
//   SessionNotifier() : super(null);
//
//   Future<void> switchUser(String userId) async {
//     if (state?.userId == userId) return;
//
//     // Close previous database
//     await state?.database.close();
//
//     // Load new tokens and DB
//     TokenPair? tokens = await _storage.getTokens(userId);
//     if (tokens == null) {
//       throw NoCachedAuthenticatedUser(
//           message: 'No Cached Token for User: $userId');
//     }
//
//     // Validate token freshness
//     if (!tokens.accessToken.isAccessTokenValid) {
//       tokens = await appLocator<TokenRefresher>().refreshToken(userId);
//     }
//
//     final newDb = AppDatabase(
//         executor: await databaseFactory.openForUser(userId), userId: userId);
//
//     state = UserDbSession(userId: userId, database: newDb, tokens: tokens);
//   }
// }
