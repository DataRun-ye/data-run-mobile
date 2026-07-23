import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:datarunmobile/core/auth/auth_api.dart';
import 'package:datarunmobile/core/auth/auth_interceptor.dart';
import 'package:datarunmobile/core/auth/auth_storage.dart';
import 'package:datarunmobile/core/auth/token_refresher.dart';
import 'package:datarunmobile/core/auth/token_storage.dart';
import 'package:datarunmobile/core/exception/http_errors.dart';
import 'package:datarunmobile/core/secure_storage/storage_service.dart';
import 'package:datarunmobile/core/user/cache_keys.dart';
import 'package:datarunmobile/core/user_session/session_storage.dart';
import 'package:datarunmobile/core/user_session/user_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences preferences;
  late _MemoryStorageService storage;
  late TokenStorage tokenStorage;
  late SessionStorage sessionStorage;
  late AuthStorage authStorage;

  setUp(() async {
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
  });

  test('logout clears active credentials but preserves the cached profile',
      () async {
    await authStorage.setActiveSession(_userSession);
    await authStorage.setActiveCredentials('test-user', _oldTokens);

    await authStorage.clearActiveUser();

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
    await authStorage.setActiveSession(_userSession);
    await authStorage.setActiveCredentials('test-user', expiredTokens);

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
    await authStorage.setActiveSession(_userSession);
    await authStorage.setActiveCredentials('test-user', expiredTokens);

    final refresher = TokenRefresher(
      tokenStorage,
      _FakeAuthApi((_) => throw StateError('refresh rejected')),
    );
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
      ..interceptors.add(
        AuthInterceptor(
          authStorage: authStorage,
          tokenRefresher: refresher,
        ),
      )
      ..httpClientAdapter = _RecordingAdapter();

    await expectLater(
      dio.get<void>('/protected'),
      throwsA(isA<RevokeTokenException>()),
    );

    expect(preferences.getString(CacheKeys.activeUserKey), isNull);
    expect(await tokenStorage.getTokens('test-user'), isNull);
    expect(sessionStorage.readSession('test-user')?.id, _userSession.id);
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

class _MemoryStorageService implements StorageService {
  final Map<String, String> values = {};

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
    values[key] = value;
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
