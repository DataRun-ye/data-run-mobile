import 'package:d_sdk/core/secure_storage/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared preferences implementation
class PrefsStorageService implements StorageService {
  PrefsStorageService({required SharedPreferences storage})
      : _storage = storage;

  final SharedPreferences _storage;

  @override
  Future<void> write(String key, String value) async {
    await _storage.setString(key, value);
  }

  @override
  Future<String?> read(String key) async {
    return _storage.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.remove(key);
  }

  @override
  Future<Map<String, String>> readAll() async {
    final all = <String, String>{};
    for (final key in _storage.getKeys()) {
      final value = _storage.getString(key);
      if (value != null) {
        all[key] = value;
      }
    }
    return all;
  }

  @override
  Future<void> deleteAll() async {
    for (final key in _storage.getKeys()) {
      await _storage.remove(key);
    }
  }
}
