import 'package:d_sdk/auth/auth_state.dart';
import 'package:d_sdk/auth/authenticated_user_detail.dart';
import 'package:d_sdk/auth/authentication_params.dart';
import 'package:d_sdk/auth/authentication_service.dart';
import 'package:d_sdk/core/cache/cache.dart';
import 'package:d_sdk/core/config/server_config.dart';
import 'package:d_sdk/core/user_session/session_storage_manager.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/use_cases/authentication/authentication.dart';
import 'package:d_sdk/use_cases/logout_strategies/logout_strategies.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_notifier.provider.g.dart';

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  Future<AuthState> build() async {
    final cachedUser = await _userSessionRepository.loadCurrentCachedUserData();
    if (cachedUser != null) {
      final dbManager = await appLocator.getAsync<DbManager>();
      final userData = await dbManager.loadAuthUserData();

      return AuthState.authenticated(AuthUserData.fromMap(userData!.toJson()));
    }
    return const AuthState.unauthenticated();
  }

  UserSessionRepository get _userSessionRepository =>
      DSdk.userSessionRepository;

  AuthenticationService get _authenticationService => DSdk.authService;

  // DbManager get _dbManager => appLocator<UserSessionRepository>();

  Future<void> _initialize() async {
    final cachedUser = await _userSessionRepository.loadCurrentCachedUserData();
    // state = cachedUser != null
    //     ? AuthState.authenticated(cachedUser)
    //     : const AuthState.unauthenticated();
  }

  // Future<bool> isAuthenticated() async {
  //   final currentUser = await _userSessionRepository.loadCurrentUser();
  //   return currentUser != null;
  // }

  Future<void> authenticate({
    required String username,
    required String password,
    required ServerConfig server,
  }) async {
    try {
      // state = const AuthState.authLoading();
      final user = await _authenticationService.auth(
        AuthenticationParams(username: username, password: password),
      );
      final cachedUser = await _updateCached(user, server.baseUrl);
      // state = AuthState.authenticated(cachedUser);
    } catch (e) {
      // state = AuthState.authErrorState(e.toString());
      rethrow;
    }
  }

  Future<void> logout({
    LogoutStrategy strategy = LogoutStrategy.keepLocalData,
  }) async {
    await _logoutCleanUp(strategy);
    // state = const AuthState.unauthenticated();
  }

  Future<void> _logoutCleanUp(
      [LogoutStrategy strategy = LogoutStrategy.keepLocalData]) async {
    final handler = await appLocator.getAsync<LogoutHandler>(param1: strategy);
    return handler.handle();
  }

  /// update cached user, and also open the database of this cached user and
  /// save its data into it
  Future<AuthUserCachedData> _updateCached(User user, String baseUrl) async {
    final cachedUser =
        AuthUserCachedData.fromJson({...user.toJson(), 'baseUrl': baseUrl});
    await _userSessionRepository.cacheCurrentAuthUserData(cachedUser);
    final dbManager = await appLocator.getAsync<DbManager>();
    await dbManager.saveAuthUserData(user);
    return cachedUser;
  }
}
