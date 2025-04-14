// import 'package:datarunmobile/stacked/app.locator.dart';
// import 'package:d_sdk/di/app_environment.dart';
// import 'package:datarunmobile/di/injection.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// part 'preference.provider.g.dart';
//
// enum Preference<T> {
//   shouldShowWalkthrough('should_show_walkthrough', true),
//   language('language', AppEnvironment.defaultLocale),
//   // appearance
//   useMaterial3('useMaterial3', true),
//
//   /// system, light, dark,
//   themeMode('themeMode', 1),
//
//   /// Available values and preference string value is the name string
//   /// of the enum value
//   /// ```dart
//   /// enum ColorSeed {
//   ///   baseColor,
//   ///   indigo,
//   ///   blue,
//   ///   teal,
//   ///   green,
//   ///   yellow,
//   ///   orange,
//   ///   deepOrange;
//   /// }
//   /// ```
//   colorSeed('colorSeed', 2),
//   colorSelectionMethod('colorSelectionMethod', 'colorSeed');
//   const Preference(this.key, this.defaultValue);
//
//   final String key;
//   final T defaultValue;
// }
//
// /// read
// ///
// /// ref.watch(preferenceNotifierProvider(Preference.shouldShowWalkthrough));
// ///
// /// write
// ///
// /// ref.read(preferenceNotifierProvider(Preference.shouldShowWalkthrough).notifier).update(false);
// @riverpod
// class PreferenceNotifier<T> extends _$PreferenceNotifier<T> {
//   @override
//   T build(Preference<T> pref) {
//     return appLocator<SharedPreferences>().getValue(pref);
//   }
//
//   Future<void> update(T value) async {
//     appLocator<SharedPreferences>().setValue(pref, value);
//     ref.invalidateSelf();
//   }
// }
//
// extension on SharedPreferences {
//   T getValue<T>(Preference<T> prefKey) {
//     if (prefKey.defaultValue is bool) {
//       final value = getBool(prefKey.key);
//       return value == null ? prefKey.defaultValue : value as T;
//     } else if (prefKey.defaultValue is int) {
//       final value = getInt(prefKey.key);
//       return value == null ? prefKey.defaultValue : value as T;
//     } else if (prefKey.defaultValue is double) {
//       final value = getDouble(prefKey.key);
//       return value == null ? prefKey.defaultValue : value as T;
//     } else if (prefKey.defaultValue is String) {
//       final value = getString(prefKey.key);
//       return value == null ? prefKey.defaultValue : value as T;
//     } else if (prefKey.defaultValue is List<String>) {
//       final value = getStringList(prefKey.key);
//       return value == null ? prefKey.defaultValue : value as T;
//     } else {
//       throw UnimplementedError(
//         '''SharedPreferencesExt.getValue: unsupported types ${prefKey.defaultValue.runtimeType}''',
//       );
//     }
//   }
//
//   Future<void> setValue<T>(Preference<T> prefKey, T value) {
//     if (value is bool) {
//       return setBool(prefKey.key, value);
//     } else if (value is int) {
//       return setInt(prefKey.key, value);
//     } else if (value is double) {
//       return setDouble(prefKey.key, value);
//     } else if (value is String) {
//       return setString(prefKey.key, value);
//     } else if (value is List<String>) {
//       return setStringList(prefKey.key, value);
//     } else {
//       throw UnimplementedError(
//         '''SharedPreferencesExt.setValue: unsupported types ${prefKey.defaultValue.runtimeType}''',
//       );
//     }
//   }
// }
