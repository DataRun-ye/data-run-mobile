// import 'package:datarun/main_constants/main_constants.dart';
// import 'package:datarun/utils/appearance_utils.dart';
// import 'package:datarun/utils/user_preferences/preference.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'app_appearance.g.dart';
//
// @riverpod
// class AppAppearanceNotifier extends _$AppAppearanceNotifier {
//   @override
//   AppAppearance build() {
//     final colorSeed = getColorSeedValue(
//         ref.watch(preferenceNotifierProvider(Preference.colorSeed)));
//     return AppAppearance(
//       useMaterial3:
//           ref.watch(preferenceNotifierProvider(Preference.useMaterial3)),
//       themeMode: getThemeModeValue(
//           ref.watch(preferenceNotifierProvider(Preference.themeMode))),
//       colorSeed: getColorSeedValue(
//           ref.watch(preferenceNotifierProvider(Preference.colorSeed))),
//       colorScheme: colorSeed != null
//           ? ColorScheme.fromSeed(seedColor: colorSeed.color)
//           : null,
//     );
//   }
//
//   // void handleBrightnessChange(bool useLightMode) {
//   //   ref
//   //       .read(preferenceNotifierProvider(Preference.themeMode).notifier)
//   //       .update(useLightMode ? ThemeMode.light.name : ThemeMode.dark.name);
//   //   // themMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
//   // }
//
//   // void handleMaterialVersionChange() {
//   //   ref
//   //       .read(preferenceNotifierProvider(Preference.useMaterial3).notifier)
//   //       .update(!state.useMaterial3);
//   //   // useMaterial3 = !state.useMaterial3;
//   // }
//
//   // void handleColorSelect(int value) {
//   //   // ref
//   //   //     .read(preferenceNotifierProvider(Preference.colorSelectionMethod)
//   //   //         .notifier)
//   //   //     .update(ColorSelectionMethod.colorSeed.name);
//   //   ref
//   //       .read(preferenceNotifierProvider(Preference.colorSeed).notifier)
//   //       .update(ColorSeed.values[value].name);
//   //
//   //   // colorSelectionMethod = ColorSelectionMethod.colorSeed;
//   //   // colorSelected = ColorSeed.values[value];
//   // }
//
//   // void handleImageSelect(int value) {
//   //   ref
//   //       .read(preferenceNotifierProvider(Preference.colorSelectionMethod)
//   //           .notifier)
//   //       .update(ColorSelectionMethod.colorSeed.name);
//   //   ref
//   //       .read(preferenceNotifierProvider(Preference.colorSeed).notifier)
//   //       .update(ColorSeed.values[value].name);
//   //
//   //   final String url = ColorImageProvider.values[value].url;
//   //   ColorScheme.fromImageProvider(provider: NetworkImage(url))
//   //       .then((ColorScheme newScheme) {
//   //     colorSelectionMethod = ColorSelectionMethod.image;
//   //     imageSelected = ColorImageProvider.values[value];
//   //     imageColorScheme = newScheme;
//   //   });
//   // }
//
//   // set colorSelectionMethod(ColorSelectionMethod method) {
//   //   state = state.copyWith(colorSelectionMethod: method);
//   // }
//
//   set colorSelected(ColorSeed colorSelected) {
//     ref
//         .read(preferenceNotifierProvider(Preference.colorSeed).notifier)
//         .update(colorSelected.name);
//
//     // state = state.copyWith(colorSeed: colorSelected);
//   }
//
// // set imageSelected(ColorImageProvider imageSelected) {
// //   state = state.copyWith(colorImageProvider: imageSelected);
// // }
//
// // set imageColorScheme(ColorScheme? imageColorScheme) {
// //   state = state.copyWith(imageColorScheme: imageColorScheme);
// // }
//
// // set themMode(ThemeMode themeMode) {
// //   ref
// //       .read(preferenceNotifierProvider(Preference.themeMode).notifier)
// //       .update(themeMode.name);
// //   state = state.copyWith(themeMode: themeMode);
// // }
// //
// // set useMaterial3(bool useMaterial3) {
// //   state = state.copyWith(useMaterial3: useMaterial3);
// // }
// }
//
// class AppAppearance with EquatableMixin {
//   AppAppearance({
//     this.useMaterial3 = false,
//     this.themeMode = ThemeMode.system,
//     this.colorSeed,
//     // this.colorImageProvider = ColorImageProvider.leaves,
//     this.colorScheme,
//     // this.colorSelectionMethod = ColorSelectionMethod.colorSeed,
//   });
//
//   final bool useMaterial3;
//   final ThemeMode themeMode;
//   final ColorSeed? colorSeed;
//
//   // final ColorImageProvider colorImageProvider;
//   final ColorScheme? colorScheme;
//
//   // final ColorSelectionMethod colorSelectionMethod;
//
//   AppAppearance copyWith({
//     bool? useMaterial3,
//     ThemeMode? themeMode,
//     ColorSeed? colorSeed,
//     // ColorImageProvider? colorImageProvider,
//     ColorScheme? imageColorScheme,
//     // ColorSelectionMethod? colorSelectionMethod
//   }) {
//     return AppAppearance(
//       useMaterial3: useMaterial3 ?? this.useMaterial3,
//       themeMode: themeMode ?? this.themeMode,
//       colorSeed: colorSeed ?? this.colorSeed,
//       // colorImageProvider: colorImageProvider ?? this.colorImageProvider,
//       colorScheme: imageColorScheme ?? this.colorScheme,
//       // colorSelectionMethod:
//       //     colorSelectionMethod ?? this.colorSelectionMethod
//     );
//   }
//
//   @override
//   List<Object?> get props => <Object?>[
//         useMaterial3,
//         themeMode,
//         colorSeed,
//         // colorImageProvider,
//         colorScheme,
//         // colorSelectionMethod
//       ];
// }
