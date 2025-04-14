import 'package:d_sdk/core/cache/cache_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
class SharedCacheStorageAdapter extends CacheStorage {
  SharedCacheStorageAdapter({required SharedPreferences cacheStorage})
      : _cacheStorage = cacheStorage,
        super(prefs: cacheStorage);
  final SharedPreferences _cacheStorage;

  @override
  Future<void> save({required String key, required String value}) async {
    await _cacheStorage.setString(key, value);
  }

  @override
  Future<String?> fetch(String key) async {
    return await _cacheStorage.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await _cacheStorage.remove(key);
  }
}
