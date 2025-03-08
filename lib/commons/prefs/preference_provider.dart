import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

part 'preference_provider.g.dart';

@Riverpod(keepAlive: true)
PreferenceProvider preferencesInstance(PreferencesInstanceRef ref) {
  return PreferenceProvider();
}

class PreferenceProvider implements InitializableDependency {
  static late final SharedPreferences? _sharedPreferences;

  //
  // static PreferenceProvider? _instance;

  // final SharedPreferences _sharedPreferences;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> initialize() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  static Future<SharedPreferences> sharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  static SharedPreferences sharedPreferencesSync() {
    if (_sharedPreferences == null)
      throw StateError('un initialized sharedPreferences');
    return _sharedPreferences!;
  }

  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setValue(String key, dynamic value) async {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    if (value != null) {
      if (value is String) {
        return _sharedPreferences!.setString(key, value);
      }

      if (value is bool) {
        return _sharedPreferences!.setBool(key, value);
      }

      if (value is int) {
        return _sharedPreferences!.setInt(key, value);
      }
      if (value is double) {
        return _sharedPreferences!.setDouble(key, value);
      }
      if (value is List<String>) {
        return _sharedPreferences!.setStringList(key, value);
      }
    }
    return Future<bool>.value(false);
  }

  Future<bool> removeValue(String key) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.remove(key);
  }

  String? getString(String key, [String? defaultValue]) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.getString(key) ?? defaultValue;
  }

  int getInt(String key, int defaultValue) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.getInt(key) ?? defaultValue;
  }

  bool getBool(String key, bool defaultValue) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.getBool(key) ?? defaultValue;
  }

  double? getDouble(String key, [double? defaultValue]) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.getDouble(key) ?? defaultValue;
  }

  List<String>? getList(String key, [List<String>? defaultValue]) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.getStringList(key) ?? defaultValue;
  }

  bool contains(Iterable<String> keys) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.getKeys().containsAll(keys);
  }

  Future<bool> clear() async {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    return _sharedPreferences!.clear();
  }

  // DateTime? lastMetadataSync() {
  //   assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
  //   return getString(LAST_META_SYNC)?.let((String lastMetadataSyncString) =>
  //       DateUtils.dateTimeFormat().parse(lastMetadataSyncString));
  // }
  //
  // DateTime? lastDataSync() {
  //   assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
  //   return getString(LAST_DATA_SYNC)?.let((String lastDataSyncString) =>
  //       DateUtils.dateTimeFormat().parse(lastDataSyncString));
  // }
  //
  // DateTime? lastSync() {
  //   assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
  //   final List<DateTime> dateSync = <DateTime>[];
  //   lastMetadataSync()?.let((DateTime it) => dateSync.add(it));
  //   lastDataSync()?.let((DateTime it) => dateSync.add(it));
  //   return dateSync.min();
  // }

  T getObjectFromJson<T>(String key, Type typeToken, [T? defaultValue]) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    // TODO: implement getObjectFromJson
    throw UnimplementedError();
  }

  void saveAsJson<T>(String key, T objectToSave) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    // TODO: implement saveAsJson
  }

  // Future<bool> saveUserCredentials(
  //     String serverUrl, String userName, String pass) async {
  //   assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
  //   // TODO(NMC):  encrypted
  //   await _sharedPreferences!.setBool(SECURE_CREDENTIALS, true);
  //   await _sharedPreferences!.setString(SECURE_SERVER_URL, serverUrl);
  //   await _sharedPreferences!.setString(SECURE_USER_NAME, userName);
  //   if (pass.isNotEmpty) {
  //     await _sharedPreferences!.setString(SECURE_PASS, pass);
  //   }
  //   return Future<bool>.value(true);
  // }

  // bool areCredentialsSet() {
  //   assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
  //   return _sharedPreferences!.getBool(SECURE_CREDENTIALS) ?? false;
  // }
  //
  // bool areSameCredentials(String? serverUrl, String? userName, String? pass) {
  //   assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
  //   return getString(SECURE_SERVER_URL, '') == serverUrl &&
  //       getString(SECURE_USER_NAME, '') == userName &&
  //       getString(SECURE_PASS, '') == pass;
  // }

  String saveJiraCredentials(String jiraAuth) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    // TODO: implement saveJiraCredentials
    throw UnimplementedError();
  }

  void saveJiraUser(String jiraUser) {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    // TODO: implement saveJiraUser
  }

  void closeJiraSession() {
    assert(_sharedPreferences != null, 'PreferenceProvider is not initialized');
    // TODO: implement closeJiraSession
  }

// SharedPreferences sharedPreferences();
// void saveUserCredentials(String serverUrl, String userName, String pass);
// bool areCredentialsSet();
// bool areSameCredentials(String serverUrl, String userName, String pass);
// String saveJiraCredentials(String jiraAuth);
// void saveJiraUser(String jiraUser);
// void closeJiraSession();
// void clear();
// void setValue(String key, dynamic value);
// void removeValue(String key);
// bool contains(/*vararg*/ List<String> keys);
// String? getString(String key, String? defaultValue);
// int getInt(String key, int defaultValue);
// // long? getLong(String key, long defaultValue);
// bool getBoolean(String key, bool defaultValue);
// double? getDouble(String key, double defaultValue);
// T getObjectFromJson<T>(
//     String key, /*TypeToken<T>*/ Type typeToken, T defaultValue);
// void saveAsJson<T>(String key, T objectToSave);
}
