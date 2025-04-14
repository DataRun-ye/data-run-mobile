import 'package:d_sdk/core/cache/cache_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageAdapter extends CacheStorage {
  SecureStorageAdapter(
      {required FlutterSecureStorage cacheStorage, required super.prefs})
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
