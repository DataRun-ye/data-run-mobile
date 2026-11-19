// Several household-list requests run at once (four villages at a time). When
// the server rejects the session with 401, the first rejection ends it; the
// other requests must still settle, or the sync never ends and a new login
// waits forever. Drives the real datasource through the real AuthInterceptor.
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/auth_interceptor.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/auth/auth_response.dart';
import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:datarunmobile/core/auth/session_operation_tracker.dart';
import 'package:datarunmobile/core/auth/token_refresher.dart';
import 'package:datarunmobile/core/auth/token_storage.dart';
import 'package:datarunmobile/core/http/default_http_adapter.dart';
import 'package:datarunmobile/core/network/reactive_connectivity_service.dart';
import 'package:datarunmobile/core/secure_storage/storage_service.dart';
import 'package:datarunmobile/core/user_session/session_storage.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:datarunmobile/data/reference_entry_repository.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/datasource/remote_data_sources/reference_entry_datasource.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  late SharedPreferences preferences;
  late TokenStorage tokenStorage;
  late AuthStorage authStorage;
  late SessionOperationTracker operationTracker;
  late _RecordingNavigationService navigationService;
  late AppDatabase database;

  setUp(() async {
    await appLocator.reset();
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    tokenStorage = TokenStorage(storage: _MemoryStorageService());
    authStorage = AuthStorage(
      tokenStorage: tokenStorage,
      sessionStorage: SessionStorage(storage: preferences),
      prefs: preferences,
    );
    operationTracker = SessionOperationTracker();
    navigationService = _RecordingNavigationService();
    appLocator.registerSingleton<NavigationService>(navigationService);
    database = AppDatabase(
      executor: NativeDatabase.memory(),
      userId: 'test-user',
    );
  });

  tearDown(() async {
    await appLocator.reset();
  });

  Future<Map<String, Object?>> runScenario({required int villages}) async {
    final validTokens = (
      accessToken: _jwtExpiringAt(DateTime.now().add(const Duration(hours: 1))),
      refreshToken: 'refresh',
    );
    await authStorage.persistAuthenticatedSession(_userSession, validTokens);
    appLocator.pushNewScope(scopeName: 'test-user');
    final authManager = AuthManager(
      authStorage: authStorage,
      authApi: _LoginAuthApi(),
      tokenRefresher: TokenRefresher(tokenStorage, _LoginAuthApi()),
      connectivityService: _FakeConnectivityService(),
      sessionOperationTracker: operationTracker,
    );
    final adapter = _DelayedUnauthorizedAdapter();
    final interceptor = AuthInterceptor(
      authStorage: authStorage,
      authManager: authManager,
      tokenRefresher: TokenRefresher(tokenStorage, _LoginAuthApi()),
    );
    interceptor.retryClient.httpClientAdapter = adapter;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..interceptors.add(interceptor)
      ..httpClientAdapter = adapter;
    final scopes = List.generate(
      villages,
      (i) => ReferenceCatalogScope(assignmentUid: 'a$i', orgUnitUid: 'o$i'),
    );
    final datasource = ReferenceEntryDatasource(
      database,
      DefaultHttpAdapter(dio),
      repository: _FixedScopeRepository(database, scopes),
    );

    var syncFinished = false;
    Object? syncError;
    unawaited(operationTracker.track(() => datasource.syncWithRemote()).then(
      (_) => syncFinished = true,
      onError: (Object e) {
        syncFinished = true;
        syncError = e;
      },
    ));
    await Future<void>.delayed(const Duration(seconds: 3));

    final statusAfterSync = authManager.status;
    final userScopeStillOpen = appLocator.hasScope('test-user');

    var loginFinished = false;
    Object? loginError;
    unawaited(authManager
        .login(username: 'test-user', password: 'password')
        .then((_) => loginFinished = true, onError: (Object e) {
      loginFinished = true;
      loginError = e;
    }));
    await Future<void>.delayed(const Duration(seconds: 3));

    return {
      'villages': villages,
      'requests': adapter.requestCount,
      'syncFinished': syncFinished,
      'syncError': syncError?.runtimeType.toString(),
      'statusAfterSync': statusAfterSync.name,
      'routes': List.of(navigationService.routes),
      'userScopeStillOpenAfter3s': userScopeStillOpen,
      'loginFinishedWithin3s': loginFinished,
      'loginError': loginError?.runtimeType.toString(),
    };
  }

  for (final villages in [1, 6]) {
    test('a 401 during household sync with $villages village(s) ends the '
        'session and lets the user log in again', () async {
      final result = await runScenario(villages: villages);

      expect(result['syncFinished'], isTrue,
          reason: 'every queued request must settle: $result');
      expect(result['userScopeStillOpenAfter3s'], isFalse,
          reason: 'the ended session must close: $result');
      expect(result['loginFinishedWithin3s'], isTrue,
          reason: 'a new login must not wait forever: $result');
    }, timeout: const Timeout(Duration(seconds: 30)));
  }
}

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
  final payload = encode({'exp': expiration.millisecondsSinceEpoch ~/ 1000});
  return '$header.$payload.signature';
}

class _FixedScopeRepository extends ReferenceEntryRepository {
  _FixedScopeRepository(super.database, this.scopes);

  final List<ReferenceCatalogScope> scopes;

  @override
  Future<List<ReferenceCatalogScope>> findSyncScopes() async => scopes;
}

class _LoginAuthApi extends AuthApi {
  @override
  Future<AuthResponse> login(username, password) async =>
      AuthResponse(accessToken: 'login-access', refreshToken: 'login-refresh');

  @override
  Future<UserSession> getUserProfile(String accessToken) async => _userSession;

  @override
  Future<TokenPair> refreshToken(String refreshToken) async =>
      (accessToken: 'new-access', refreshToken: 'new-refresh');
}

class _FakeConnectivityService implements ConnectivityService {
  @override
  Future<bool> get isOnline async => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MemoryStorageService implements StorageService {
  final Map<String, String> values = {};

  @override
  Future<void> delete(String key) async => values.remove(key);

  @override
  Future<void> deleteAll() async => values.clear();

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<Map<String, String?>> readAll() async => Map.of(values);

  @override
  Future<void> write(String key, String value) async => values[key] = value;
}

/// Answers every request with 401 after a short delay, so several requests
/// can be in flight when the first rejection arrives.
class _DelayedUnauthorizedAdapter implements HttpClientAdapter {
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
    await Future<void>.delayed(const Duration(milliseconds: 50));
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
