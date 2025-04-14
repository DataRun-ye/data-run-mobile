// import 'package:d_sdk/auth/auth_manager.dart';
// import 'package:d_sdk/auth/auth_state.dart';
// import 'package:d_sdk/auth/authentication_params.dart';
// import 'package:d_sdk/auth/authentication_service.dart';
// import 'package:d_sdk/core/cache/cache.dart';
// import 'package:d_sdk/core/user_session/session_storage_manager.dart';
// import 'package:d_sdk/database/database.dart';
// import 'package:d_sdk/use_cases/logout_strategies/logout_strategies.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:injectable/injectable.dart';
//
// @LazySingleton(as: AuthManager)
// class AppAuthManager extends StateNotifier<AuthState> implements AuthManager {
//   AppAuthManager({
//     required UserSessionRepository userSessionRepository,
//     required AuthenticationService authenticationService,
//     required DbManager dbManager,
//   })  : _userSessionRepository = userSessionRepository,
//         _authenticationService = authenticationService,
//         _dbManager = dbManager,
//         super(AuthState.authLoading()) {
//     _initialize();
//   }
//
//   final UserSessionRepository _userSessionRepository;
//   final AuthenticationService _authenticationService;
//   final DbManager _dbManager;
//
//   Future<void> _initialize() async {
//     final cachedUser = await _userSessionRepository.loadCurrentUser();
//     state = cachedUser != null
//         ? AuthState.authenticated(cachedUser)
//         : AuthState.unauthenticated();
//   }
//
//   @override
//   Future<bool> isAuthenticated() async {
//     final currentUser = await _userSessionRepository.loadCurrentUser();
//     return currentUser != null;
//   }
//
//   @override
//   Future<void> authenticate({
//     required String username,
//     required String password,
//     required ServerConfig server,
//   }) async {
//     try {
//       state = AuthState.authLoading();
//       final user = await _authenticationService.auth(
//         AuthenticationParams(username: username, password: password),
//       );
//       final cachedUser = await _updateCached(user, server.baseUrl);
//       state = AuthState.authenticated(cachedUser);
//     } catch (e) {
//       state = AuthState.authErrorState(e.toString());
//       rethrow;
//     }
//   }
//
//   @override
//   Future<void> logout(
//       {LogoutStrategy strategy = LogoutStrategy.keepLocalData}) async {
//     state = AuthState.authLoading();
//     await _logoutCleanUp(strategy);
//     state = AuthState.unauthenticated();
//   }
//
//   Future<void> _logoutCleanUp(LogoutStrategy strategy) async {
//     final handler = _logoutHandlerFactory.create(strategy);
//     await handler.handle();
//   }
//
//   Future<AuthUserCachedData> _updateCached(User user, String baseUrl) async {
//     final cachedUser =
//         AuthUserCachedData.fromJson({...user.toJson(), 'baseUrl': baseUrl});
//     await _userSessionRepository.cacheCurrentAuthUserData(cachedUser);
//     await _dbManager.saveAuthUserData(user);
//     return cachedUser;
//   }
//
//   @override
//   AuthState get currentState => state;
// }
//
// // Provider setup
// final authManagerProvider = StateNotifierProvider<AuthManager, AuthState>(
//   (ref) => SdkAuthManager(
//     userSessionRepository: ref.watch(userSessionRepositoryProvider),
//     authenticationService: ref.watch(authenticationServiceProvider),
//     dbManager: ref.watch(dbManagerProvider),
//     logoutHandlerFactory: ref.watch(logoutHandlerFactoryProvider),
//   ),
// );
//
// // Usage in Auto Route Guard
// class AuthGuard extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, RouterDelegate router) async {
//     final authState = ref.read(authManagerProvider);
//
//     if (authState is AuthAuthenticatedState) {
//       resolver.next(true);
//     } else if (authState is AuthUnauthenticatedState) {
//       resolver.next(false);
//       // Redirect to login
//     } else if (authState is AuthErrorState) {
//       resolver.next(false);
//       // Handle error
//     } else {
//       // Loading state, wait for resolution
//       final subscription = ref.listen(authManagerProvider, (previous, next) {
//         if (next is! AuthLoadingState) {
//           subscription.close();
//           resolver.resolveNext(next is AuthAuthenticatedState);
//         }
//       });
//     }
//   }
// }
