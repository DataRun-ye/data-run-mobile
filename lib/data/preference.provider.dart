import 'package:d_sdk/di/app_environment.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preference.provider.g.dart';

enum Preference {
  shouldShowWalkthrough('should_show_walkthrough', true),
  language('language', AppEnvironment.defaultLocale),
  // appearance
  useMaterial3('useMaterial3', true),
  themeMode('themeMode', 1),
  colorSeed('colorSeed', 2),
  colorSelectionMethod('colorSelectionMethod', 'colorSeed');

  const Preference(this.key, this.defaultValue);

  final String key;
  final Object defaultValue;
}

/// read
///
/// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
///
/// write
///
/// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
@riverpod
class PreferenceNotifier extends _$PreferenceNotifier {
  @override
  dynamic build(Preference pref) {
    return appLocator<SharedPreferences>().getValue(pref);
  }

  Future<void> update(dynamic value) async {
    appLocator<SharedPreferences>().setValue(pref, value);
    ref.invalidateSelf();
  }
}

extension SharedPreferencesExt on SharedPreferences {
  dynamic getValue(Preference prefKey) {
    final def = prefKey.defaultValue;
    if (def is bool) {
      final value = getBool(prefKey.key);
      return value ?? def;
    } else if (def is int) {
      final value = getInt(prefKey.key);
      return value ?? def;
    } else if (def is double) {
      final value = getDouble(prefKey.key);
      return value ?? def;
    } else if (def is String) {
      final value = getString(prefKey.key);
      return value ?? def;
    } else if (def is List<String>) {
      final value = getStringList(prefKey.key);
      return value ?? def;
    } else {
      throw UnimplementedError(
        'Unsupported type ${def.runtimeType} for key ${prefKey.key}',
      );
    }
  }

  Future<void> setValue(Preference prefKey, dynamic value) {
    final def = prefKey.defaultValue;
    if (value is bool && def is bool) {
      return setBool(prefKey.key, value);
    } else if (value is int && def is int) {
      return setInt(prefKey.key, value);
    } else if (value is double && def is double) {
      return setDouble(prefKey.key, value);
    } else if (value is String && def is String) {
      return setString(prefKey.key, value);
    } else if (value is List<String> && def is List<String>) {
      return setStringList(prefKey.key, value);
    } else {
      throw UnimplementedError(
        'Unsupported type ${def.runtimeType} for key ${prefKey.key}',
      );
    }
  }
}
