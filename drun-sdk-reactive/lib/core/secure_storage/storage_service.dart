/// Generic interface for session storage
typedef FutureCallback<T> = Future<T> Function();

enum StorageType { secure, prefs }

/// Secure implementation
/// Usage example:
///```dart
/// final storage = await StorageServiceFactory.getService(StorageType.secure);
/// await storage.write('user_session', jsonString);
/// final json = await storage.read('user_session');
///
/// // Read all entries:
/// final all = await storage.readAll();
///
/// // Delete everything:
/// await storage.deleteAll();
/// ```
abstract class StorageService {
  Future<void> write(String key, String value);

  Future<String?> read(String key);

  Future<void> delete(String key);

  /// Read all key/value pairs
  Future<Map<String, String?>> readAll();

  /// Delete all stored entries
  Future<void> deleteAll();
}

