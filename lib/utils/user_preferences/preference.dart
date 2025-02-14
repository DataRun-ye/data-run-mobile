import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preference.g.dart';

enum Preference<T> {
  shouldShowWalkthrough('should_show_walkthrough', true),
  themeMode('theme_mode', 0),
  material3('material_3', false),
  language('language', 'ar'),
  appColor('app_color', '');
  // credentialsSet(SECURE_CREDENTIALS, false),
  // serverUrl(SECURE_SERVER_URL, ''),
  // username(SECURE_USER_NAME, '');

  // override fun saveUserCredentials(serverUrl: String, userName: String, pass: String) {
  // setValue(SECURE_CREDENTIALS, true)
  // setValue(SECURE_SERVER_URL, serverUrl)
  // setValue(SECURE_USER_NAME, userName)
  // }
  //
  // override fun areCredentialsSet(): Boolean {
  // return getBoolean(SECURE_CREDENTIALS, false)
  // }
  //
  // override fun areSameCredentials(serverUrl: String, userName: String, pass: String): Boolean {
  // return getString(SECURE_SERVER_URL, "") == serverUrl &&
  // getString(SECURE_USER_NAME, "") == userName
  // }
  //
  // override fun saveJiraCredentials(jiraAuth: String): String {
  // return String.format("Basic %s", jiraAuth)
  // }
  //
  // override fun clear() {
  // sharedPreferences.edit().clear().apply()
  // }

  const Preference(this.key, this.defaultValue);

  final String key;
  final T defaultValue;
}

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) =>
    throw UnimplementedError();

/// read
///
/// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
@riverpod
class PreferenceNotifier<T> extends _$PreferenceNotifier<T> {
  @override
  T build(Preference<T> pref) {
    return ref.watch(sharedPreferencesProvider).getValue(pref);
  }

  Future<void> update(T value) async {
    await ref.read(sharedPreferencesProvider).setValue(pref, value);
    ref.invalidateSelf();
  }
}

extension on SharedPreferences {
  T getValue<T>(Preference<T> prefKey) {
    if (prefKey.defaultValue is bool) {
      final value = getBool(prefKey.key);
      return value == null ? prefKey.defaultValue : value as T;
    } else if (prefKey.defaultValue is int) {
      final value = getInt(prefKey.key);
      return value == null ? prefKey.defaultValue : value as T;
    } else if (prefKey.defaultValue is double) {
      final value = getDouble(prefKey.key);
      return value == null ? prefKey.defaultValue : value as T;
    } else if (prefKey.defaultValue is String) {
      final value = getString(prefKey.key);
      return value == null ? prefKey.defaultValue : value as T;
    } else if (prefKey.defaultValue is List<String>) {
      final value = getStringList(prefKey.key);
      return value == null ? prefKey.defaultValue : value as T;
    } else {
      throw UnimplementedError(
        '''SharedPreferencesExt.getValue: unsupported types ${prefKey.defaultValue.runtimeType}''',
      );
    }
  }

  Future<void> setValue<T>(Preference<T> prefKey, T value) {
    if (value is bool) {
      return setBool(prefKey.key, value);
    } else if (value is int) {
      return setInt(prefKey.key, value);
    } else if (value is double) {
      return setDouble(prefKey.key, value);
    } else if (value is String) {
      return setString(prefKey.key, value);
    } else if (value is List<String>) {
      return setStringList(prefKey.key, value);
    } else {
      throw UnimplementedError(
        '''SharedPreferencesExt.setValue: unsupported types ${prefKey.defaultValue.runtimeType}''',
      );
    }
  }
}
