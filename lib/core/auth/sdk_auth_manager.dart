
import 'package:d_sdk/auth/auth_manager.dart' show AuthManager;
import 'package:d_sdk/auth/auth_state.dart';
import 'package:d_sdk/auth/authenticated_user_detail.dart';
import 'package:d_sdk/auth/authentication_params.dart' show AuthenticationParams;
import 'package:d_sdk/auth/authentication_service.dart';
import 'package:d_sdk/core/cache/cached_user_detail.dart';
import 'package:d_sdk/core/config/server_config.dart';
import 'package:d_sdk/core/user_session/session_storage_manager.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/di/injection.dart' show rSdkLocator, setupSdkLocator;
import 'package:d_sdk/use_cases/logout_strategies/logout_handler.dart';
import 'package:d_sdk/use_cases/logout_strategies/logout_strategy.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: AuthManager)
class SdkAuthManager implements AuthManager {
  SdkAuthManager(
      {required UserSessionRepository userSessionRepository,
      required AuthenticationService authenticationService})
      : _authenticationService = authenticationService,
        _userSessionRepository = userSessionRepository;
  // {
  //   _loadSessionData();
  // }

  final AuthenticationService _authenticationService;
  final UserSessionRepository _userSessionRepository;

  final BehaviorSubject<AuthState> _authStateController =
      BehaviorSubject<AuthState>.seeded(AuthState.authLoading());

  @override
  Stream<AuthState> get authStateStream => _authStateController.stream;

  @override
  AuthState get currentState => _authStateController.value;

  Future<void> _loadSessionData() async {
    // _authStateController.add(AuthState.authLoading());
    final cachedUser = await _userSessionRepository.loadCurrentCachedUserData();
    if (cachedUser != null) {
      await setupSdkLocator();
      final dbManager = rSdkLocator.get<DbManager>();
      final userData = await dbManager.loadAuthUserData();
      if (userData != null) {
        _authStateController.add(
            AuthState.authenticated(AuthUserData.fromMap(userData.toJson())));
      } else {
        _authStateController.add(AuthState.unauthenticated());
      }
    } else {
      _authStateController.add(AuthState.unauthenticated());
    }
  }

  @override
  bool isAuthenticated() {
    final currentDbName = _userSessionRepository.getCurrentDbName();
    return currentDbName != null;
  }

  @override
  Future<void> authenticate(
      {required String username,
      required String password,
      required ServerConfig server}) async {
    try {
      _authStateController.add(AuthState.authLoading());

      // Authenticate with server
      final User authUserData = await _authenticationService
          .auth(AuthenticationParams(username: username, password: password));
      final cached = await _updateCached(authUserData, server.baseUrl);
      _authStateController.add(
          AuthState.authenticated(AuthUserData.fromMap(authUserData.toJson())));
    } catch (e) {
      _authStateController.add(AuthState.authErrorState(e.toString()));
    }
  }

  @override
  Future<void> logout(
      {LogoutStrategy strategy = LogoutStrategy.keepLocalData}) async {
    await _logoutCleanUp(strategy);
    _authStateController.add(AuthState.unauthenticated());
  }

  Future<void> _logoutCleanUp(
      [LogoutStrategy strategy = LogoutStrategy.keepLocalData]) async {
    final handler = await rSdkLocator.getAsync<LogoutHandler>(param1: strategy);
    return handler.handle();
  }

  /// update cached user, and also open the database of this cached user and
  /// save its data into it
  Future<AuthUserCachedData> _updateCached(User user, String baseUrl) async {
    final cachedUser =
        AuthUserCachedData.fromJson({...user.toJson(), 'baseUrl': baseUrl});
    await _userSessionRepository.cacheCurrentAuthUserData(cachedUser);
    final dbManager = await rSdkLocator.getAsync<DbManager>();
    await dbManager.saveAuthUserData(user);
    return cachedUser;
  }

  @override
  Future<void> dispose() async {
    await _authStateController.close();
  }
}
