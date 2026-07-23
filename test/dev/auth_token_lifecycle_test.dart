import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/auth_interceptor.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/auth/auth_response.dart';
import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:datarunmobile/core/auth/token_refresher.dart';
import 'package:datarunmobile/core/auth/token_storage.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/http/default_http_adapter.dart';
import 'package:datarunmobile/core/secure_storage/storage_service.dart';
import 'package:datarunmobile/core/user/cache_keys.dart';
import 'package:datarunmobile/core/user_session/session_storage.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:datarunmobile/database/db_factory/database_factory.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show QueryExecutor;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  late SharedPreferences preferences;
  late _MemoryStorageService storage;
  late TokenStorage tokenStorage;
  late SessionStorage sessionStorage;
  late AuthStorage authStorage;
  late SessionOperationTracker operationTracker;
  late _RecordingNavigationService navigationService;

  setUp(() async {
    await appLocator.reset();
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    storage = _MemoryStorageService();
    tokenStorage = TokenStorage(storage: storage);
    sessionStorage = SessionStorage(storage: preferences);
    authStorage = AuthStorage(
      tokenStorage: tokenStorage,
      sessionStorage: sessionStorage,
      prefs: preferences,
    );
    operationTracker = SessionOperationTracker();
    navigationService = _RecordingNavigationService();
    appLocator.registerSingleton<NavigationService>(navigationService);
  });

  tearDown(appLocator.reset);

  AuthManager createAuthManager() => AuthManager(
        authStorage: authStorage,
        authApi: _FakeAuthApi((_) async => _newTokens),
        sessionOperationTracker: operationTracker,
      );

  test('logout clears active credentials but preserves the cached profile',
      () async {
    await authStorage.persistAuthenticatedSession(_userSession, _oldTokens);

    await authStorage.clearActiveUser();

    expect(preferences.getString(CacheKeys.activeUserKey), isNull);
    expect(await tokenStorage.getTokens('test-user'), isNull);
    expect(sessionStorage.readSession('test-user')?.id, _userSession.id);
  });

  test('login storage failure never opens a user database scope', () async {
    final databaseFactory = _TestDatabaseFactory();
    appLocator.registerSingleton<DatabaseFactory>(
      databaseFactory,
      dispose: (factory) => factory.close(),
    );
    storage.failWriteKey = CacheKeys.getRefreshTokenKey('test-user');
    final authManager = AuthManager(
      authStorage: authStorage,
      authApi: _LoginAuthApi(),
      sessionOperationTracker: operationTracker,
    );

    await expectLater(
      authManager.login(username: 'test-user', password: 'password'),
      throwsA(isA<StateError>()),
    );

    expect(databaseFactory.openCalls, 0);
    expect(appLocator.hasScope('test-user'), isFalse);
    expect(authManager.status, AuthStatus.unauthenticated);
    expect(preferences.getString(CacheKeys.activeUserKey), isNull);
    expect(await tokenStorage.getTokens('test-user'), isNull);
    expect(sessionStorage.readSession('test-user')?.id, _userSession.id);
  });

  test('login activation failure rolls back committed credentials', () async {
    final databaseFactory = _TestDatabaseFactory(failOpen: true);
    appLocator.registerSingleton<DatabaseFactory>(
      databaseFactory,
      dispose: (factory) => factory.close(),
    );
    final authManager = AuthManager(
      authStorage: authStorage,
      authApi: _LoginAuthApi(),
      sessionOperationTracker: operationTracker,
    );

    await expectLater(
      authManager.login(username: 'test-user', password: 'password'),
      throwsA(isA<StateError>()),
    );

    expect(databaseFactory.openCalls, 1);
    expect(appLocator.hasScope('test-user'), isFalse);
    expect(authManager.status, AuthStatus.unauthenticated);
    expect(preferences.getString(CacheKeys.activeUserKey), isNull);
    expect(await tokenStorage.getTokens('test-user'), isNull);
    expect(sessionStorage.readSession('test-user')?.id, _userSession.id);
  });

  test('successful login owns and closes one user database scope', () async {
    final databaseFactory = _TestDatabaseFactory();
    appLocator.registerSingleton<DatabaseFactory>(
      databaseFactory,
      dispose: (factory) => factory.close(),
    );
    final authManager = AuthManager(
      authStorage: authStorage,
      authApi: _LoginAuthApi(),
      sessionOperationTracker: operationTracker,
    );

    final session =
        await authManager.login(username: 'test-user', password: 'password');

    expect(session, same(_userSession));
    expect(authManager.status, AuthStatus.authenticated);
    expect(appLocator.hasScope('test-user'), isTrue);
    expect(databaseFactory.openCalls, 1);
    expect(preferences.getString(CacheKeys.activeUserKey), 'test-user');
    expect(await tokenStorage.getTokens('test-user'), _loginTokens);

    await authManager.logout();

    expect(authManager.status, AuthStatus.unauthenticated);
    expect(appLocator.hasScope('test-user'), isFalse);
    expect(databaseFactory.closeForUserCalls, 1);
    expect(preferences.getString(CacheKeys.activeUserKey), isNull);
    expect(await tokenStorage.getTokens('test-user'), isNull);
    expect(sessionStorage.readSession('test-user')?.id, _userSession.id);
  });

  test('concurrent refresh calls rotate and persist one token pair', () async {
    await tokenStorage.saveTokens('test-user', _oldTokens);
    final releaseRefresh = Completer<void>();
    var refreshCalls = 0;
    final api = _FakeAuthApi((refreshToken) async {
      refreshCalls++;
      expect(refreshToken, _oldTokens.refreshToken);
      await releaseRefresh.future;
      return _newTokens;
    });
    final refresher = TokenRefresher(tokenStorage, api);

    final first = refresher.refreshToken('test-user');
    final second = refresher.refreshToken('test-user');
    releaseRefresh.complete();

    expect(await Future.wait([first, second]), [_newTokens, _newTokens]);
    expect(refreshCalls, 1);
    expect(await tokenStorage.getTokens('test-user'), _newTokens);
  });

  test('expired authenticated request uses the persisted rotated access token',
      () async {
    final expiredTokens = (
      accessToken: _jwtExpiringAt(
        DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      refreshToken: _oldTokens.refreshToken,
    );
    final rotatedTokens = (
      accessToken: _jwtExpiringAt(
        DateTime.now().add(const Duration(hours: 1)),
      ),
      refreshToken: _newTokens.refreshToken,
    );
    await authStorage.persistAuthenticatedSession(
      _userSession,
      expiredTokens,
    );

    var refreshCalls = 0;
    final refresher = TokenRefresher(
      tokenStorage,
      _FakeAuthApi((refreshToken) async {
        refreshCalls++;
        expect(refreshToken, expiredTokens.refreshToken);
        return rotatedTokens;
      }),
    );
    final adapter = _RecordingAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..interceptors.add(
        AuthInterceptor(
          authStorage: authStorage,
          authManager: createAuthManager(),
          tokenRefresher: refresher,
        ),
      )
      ..httpClientAdapter = adapter;

    await dio.get<void>('/protected');

    expect(refreshCalls, 1);
    expect(
      adapter.lastRequest?.headers['Authorization'],
      'Bearer ${rotatedTokens.accessToken}',
    );
    expect(await tokenStorage.getTokens('test-user'), rotatedTokens);
  });

  test('failed request refresh clears credentials but keeps cached profile',
      () async {
    final expiredTokens = (
      accessToken: _jwtExpiringAt(
        DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      refreshToken: _oldTokens.refreshToken,
    );
    await authStorage.persistAuthenticatedSession(
      _userSession,
      expiredTokens,
    );
    appLocator.pushNewScope(scopeName: 'test-user');

    final refresher = TokenRefresher(
      tokenStorage,
      _FakeAuthApi((_) => throw StateError('refresh rejected')),
    );
    final authManager = createAuthManager();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..interceptors.add(
        AuthInterceptor(
          authStorage: authStorage,
          authManager: authManager,
          tokenRefresher: refresher,
        ),
      )
      ..httpClientAdapter = _RecordingAdapter();

    var scopeWasOpenDuringFailureCleanup = false;
    await expectLater(
      operationTracker.track(() async {
        try {
          return await DefaultHttpAdapter(dio).request(
            resourceName: 'protected',
            path: '/protected',
            method: 'get',
          );
        } catch (_) {
          scopeWasOpenDuringFailureCleanup = appLocator.hasScope('test-user');
          rethrow;
        }
      }),
      throwsA(isA<RevokeTokenException>()),
    );
    await _waitFor(() => !appLocator.hasScope('test-user'));

    expect(scopeWasOpenDuringFailureCleanup, isTrue);
    expect(authManager.status, AuthStatus.unauthenticated);
    expect(navigationService.routes, [Routes.loginView]);
    expect(preferences.getString(CacheKeys.activeUserKey), isNull);
    expect(await tokenStorage.getTokens('test-user'), isNull);
    expect(sessionStorage.readSession('test-user')?.id, _userSession.id);
  });

  test('a repeated 401 with a valid token expires the session', () async {
    final validTokens = (
      accessToken: _jwtExpiringAt(
        DateTime.now().add(const Duration(hours: 1)),
      ),
      refreshToken: _oldTokens.refreshToken,
    );
    await authStorage.persistAuthenticatedSession(_userSession, validTokens);
    appLocator.pushNewScope(scopeName: 'test-user');
    final authManager = createAuthManager();
    final adapter = _UnauthorizedAdapter();
    final interceptor = AuthInterceptor(
      authStorage: authStorage,
      authManager: authManager,
      tokenRefresher: TokenRefresher(
        tokenStorage,
        _FakeAuthApi((_) async => _newTokens),
      ),
    );
    interceptor.retryClient.httpClientAdapter = adapter;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..interceptors.add(interceptor)
      ..httpClientAdapter = adapter;

    await expectLater(
      operationTracker.track(
        () => DefaultHttpAdapter(dio).request(
          resourceName: 'protected',
          path: '/protected',
          method: 'get',
        ),
      ),
      throwsA(isA<RevokeTokenException>()),
    );
    await _waitFor(() => !appLocator.hasScope('test-user'));

    expect(adapter.requestCount, 2);
    expect(authManager.status, AuthStatus.unauthenticated);
    expect(navigationService.routes, [Routes.loginView]);
    expect(await tokenStorage.getTokens('test-user'), isNull);
  });

  test('concurrent session expiration drains operations and navigates once',
      () async {
    await authStorage.persistAuthenticatedSession(_userSession, _oldTokens);
    appLocator.pushNewScope(scopeName: 'test-user');
    final authManager = createAuthManager();
    final releaseOperation = Completer<void>();
    final operation = operationTracker.track(() => releaseOperation.future);

    await Future.wait([
      authManager.expireSession(),
      authManager.expireSession(),
    ]);

    expect(authManager.status, AuthStatus.unauthenticated);
    expect(navigationService.routes, [Routes.loginView]);
    expect(appLocator.hasScope('test-user'), isTrue);

    releaseOperation.complete();
    await operation;
    await _waitFor(() => !appLocator.hasScope('test-user'));

    expect(appLocator.hasScope('test-user'), isFalse);
  });
}

const _oldTokens = (
  accessToken: 'old-access-token',
  refreshToken: 'old-refresh-token',
);
const _newTokens = (
  accessToken: 'new-access-token',
  refreshToken: 'new-refresh-token',
);
const _loginTokens = (
  accessToken: 'login-access-token',
  refreshToken: 'login-refresh-token',
);

const _userSession = UserSession(
  id: 'user-id',
  username: 'test-user',
  activated: true,
  authorities: [],
  activityUIDs: [],
  userTeamsUIDs: [],
  managedTeamsUIDs: [],
  userGroupsUIDs: [],
  userFormsUIDs: [],
);

String _jwtExpiringAt(DateTime expiration) {
  String encode(Map<String, Object> value) =>
      base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');

  final header = encode({'alg': 'none', 'typ': 'JWT'});
  final payload = encode({
    'exp': expiration.millisecondsSinceEpoch ~/ 1000,
  });
  return '$header.$payload.signature';
}

class _FakeAuthApi extends AuthApi {
  _FakeAuthApi(this._refresh);

  final Future<TokenPair> Function(String refreshToken) _refresh;

  @override
  Future<TokenPair> refreshToken(String refreshToken) => _refresh(refreshToken);
}

class _LoginAuthApi extends AuthApi {
  @override
  Future<AuthResponse> login(username, password) async => AuthResponse(
        accessToken: _loginTokens.accessToken,
        refreshToken: _loginTokens.refreshToken,
      );

  @override
  Future<UserSession> getUserProfile(String accessToken) async => _userSession;
}

class _MemoryStorageService implements StorageService {
  final Map<String, String> values = {};
  String? failWriteKey;

  @override
  Future<void> delete(String key) async {
    values.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    values.clear();
  }

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<Map<String, String?>> readAll() async => Map.of(values);

  @override
  Future<void> write(String key, String value) async {
    if (key == failWriteKey) {
      throw StateError('Secure storage write failed: $key');
    }
    values[key] = value;
  }
}

class _TestDatabaseFactory extends DatabaseFactory {
  _TestDatabaseFactory({this.failOpen = false});

  final bool failOpen;
  final _executors = <QueryExecutor>[];
  var openCalls = 0;
  var closeForUserCalls = 0;

  @override
  Future<QueryExecutor> openForUser(String userId) async {
    openCalls++;
    if (failOpen) {
      throw StateError('Database open failed: $userId');
    }
    final executor = NativeDatabase.memory();
    _executors.add(executor);
    return executor;
  }

  @override
  Future<void> closeForUser(String userId) async {
    closeForUserCalls++;
    await close();
  }

  @override
  Future<void> close() async {
    for (final executor in _executors) {
      await executor.close();
    }
    _executors.clear();
  }
}

class _RecordingAdapter implements HttpClientAdapter {
  RequestOptions? lastRequest;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return ResponseBody.fromString(
      '{}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class _UnauthorizedAdapter implements HttpClientAdapter {
  var requestCount = 0;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    return ResponseBody.fromString(
      '{}',
      401,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class _RecordingNavigationService extends NavigationService {
  final routes = <String>[];

  @override
  Future<T?>? clearStackAndShow<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    routes.add(routeName);
    return Future<T?>.value();
  }
}

Future<void> _waitFor(bool Function() condition) async {
  for (var attempt = 0; attempt < 20; attempt++) {
    if (condition()) return;
    await Future<void>.delayed(Duration.zero);
  }
  fail('Condition did not become true');
}
