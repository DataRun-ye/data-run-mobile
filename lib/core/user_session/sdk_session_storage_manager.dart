import 'dart:convert';

import 'package:d_sdk/core/cache/cache.dart';
import 'package:d_sdk/core/user_session/session_storage_manager.dart';
import 'package:d_sdk/core/utilities/list_extensions.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SdkUserSessionRepository implements UserSessionRepository {
  SdkUserSessionRepository({required CacheStorage cacheStorage})
      : _cacheStorage = cacheStorage;

  final CacheStorage _cacheStorage;

  @override
  String? getCurrentDbName() {
    return _cacheStorage.getCurrentDbName();
  }

  @override
  Future<AuthUserCachedData?> loadCurrentCachedUserData() async {
    final String? currentDbFileName = getCurrentDbName();

    final String? cachedListString =
        await _cacheStorage.fetch(CacheKeys.cachedUsersKey);

    List<AuthUserCachedData> cachedList = [];
    if (cachedListString != null) {
      final List<dynamic> decoded = jsonDecode(cachedListString);
      cachedList
          .addAll(decoded.map((json) => AuthUserCachedData.fromJson(json)));
    }

    if ((currentDbFileName ?? '').isEmpty || cachedList.isEmpty) return null;

    return cachedList
        .firstOrNullWhere((u) => currentDbFileName == u.dbFileName);
  }

  @override
  Future<void> cacheCurrentAuthUserData(AuthUserCachedData user) async {
    // save current User on top
    await _cacheStorage.save(
      key: CacheKeys.currentDbFileNameKey,
      value: user.dbFileName,
    );
  }

  @override
  Future<List<AuthUserCachedData>> getCachedAuthUsers() async {
    final String? cachedListString =
        await _cacheStorage.fetch(CacheKeys.cachedUsersKey);

    List<AuthUserCachedData> cachedList = [];
    if (cachedListString != null) {
      final List<dynamic> decoded = jsonDecode(cachedListString);
      cachedList
          .addAll(decoded.map((json) => AuthUserCachedData.fromJson(json)));
    }

    return cachedList;
  }

  @override
  Future<void> logoutCurrentAuthCachedUser() async {
    await _cacheStorage.removeCurrentDbFileName();
  }
}
