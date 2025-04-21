import 'package:d_sdk/user_session/user_session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheStorageAdapter extends CacheStorageAdapter {
  SecureCacheStorageAdapter({required FlutterSecureStorage cacheStorage})
      : _cacheStorage = cacheStorage;
  final FlutterSecureStorage _cacheStorage;

  @override
  Future<void> save({required String key, required String value}) async {
    await _cacheStorage.write(key: key, value: value);
  }

  @override
  Future<String?> fetch(String key) async {
    return await _cacheStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await _cacheStorage.delete(key: key);
  }
}
