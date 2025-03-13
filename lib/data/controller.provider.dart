// import 'package:flutter/material.dart';
// import 'package:datarunmobile/commons/prefs/preference_provider.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// import '../data_run/screens/form_ui_elements/org_unit_picker/settings/shared.dart' show IndentGuideType, LineStyle, enumByName;
//
// part 'controller.provider.g.dart';
//
// @riverpod
// Duration watchAnimationDurationSetting(WatchAnimationDurationSettingRef ref) {
//   final animateExpansions = ref.watch(settingsControllerProvider
//       .select((setting) => setting.animateExpansions));
//
//   return animateExpansions ? const Duration(milliseconds: 300) : Duration.zero;
// }
//
// @riverpod
// class SettingsController extends _$SettingsController {
//   SettingsState build() {
//     final prefProvider = ref.watch(preferencesInstanceProvider);
//     return SettingsState.fromPreferences(prefProvider);
//   }
//
//   PreferenceProvider _getPrefProvider() {
//     return ref.watch(preferencesInstanceProvider);
//   }
//
//   void settingState(SettingsState Function(SettingsState state) value) {
//     state = value.call(state);
//   }
//
//   void reset() {
//     state = const SettingsState();
//     // PreferenceProvider.sharedPreferences().then((prefs) => prefs.clear());
//   }
//
//   void updateAnimateExpansions(bool value) {
//     if (value == state.animateExpansions) return;
//     state = state.copyWith(animateExpansions: value);
//     PreferenceProvider.sharedPreferences().then((prefs) => prefs.clear());
//     _getPrefProvider().setValue(animateExpansionsKey, value);
//   }
//
//   void updateColor(Color value) {
//     if (state.color == value) return;
//     state = state.copyWith(color: value);
//     _getPrefProvider().setValue(colorKey, value.value);
//   }
//
//   void updateConnectBranches(bool value) {
//     if (state.connectBranches == value) return;
//     state = state.copyWith(connectBranches: value);
//     // prefs.setBool(connectBranchesKey, value);
//   }
//
//   void updateIndent(double value) {
//     if (state.indent == value) return;
//     state = state.copyWith(indent: value);
//     _getPrefProvider().setValue(indentKey, value);
//   }
//
//   void updateIndentGuideType(IndentGuideType value) {
//     if (state.indentGuideType == value) return;
//     state = state.copyWith(indentGuideType: value);
//     _getPrefProvider().setValue(indentGuideTypeKey, value.name);
//   }
//
//   void updateLineOrigin(double value) {
//     if (state.lineOrigin == value) return;
//     state = state.copyWith(lineOrigin: value);
//     _getPrefProvider().setValue(lineOriginKey, value);
//   }
//
//   void updateLineStyle(LineStyle value) {
//     if (state.lineStyle == value) return;
//     state = state.copyWith(lineStyle: value);
//     _getPrefProvider().setValue(lineStyleKey, value.name);
//   }
//
//   void updateLineThickness(double value) {
//     if (state.lineThickness == value) return;
//     state = state.copyWith(lineThickness: value);
//     _getPrefProvider().setValue(lineThicknessKey, value);
//   }
//
//   void updateRoundedCorners(bool value) {
//     if (state.roundedCorners == value) return;
//     state = state.copyWith(roundedCorners: value);
//     _getPrefProvider().setValue(roundedCornersKey, value);
//   }
//
//   void updateTextDirection(TextDirection value) {
//     if (state.textDirection == value) return;
//     state = state.copyWith(textDirection: value);
//     _getPrefProvider().setValue(textDirectionKey, value.name);
//   }
//
//   void updateThemeMode(ThemeMode value) {
//     if (state.themeMode == value) return;
//     state = state.copyWith(themeMode: value);
//     _getPrefProvider().setValue(themeModeKey, value.name);
//   }
// }
//
// class SettingsState {
//   const SettingsState({
//     this.animateExpansions = false,
//     this.color = Colors.blue,
//     this.connectBranches = false,
//     this.indent = 40.0,
//     this.indentGuideType = IndentGuideType.connectingLines,
//     this.lineOrigin = 0.5,
//     this.lineStyle = LineStyle.solid,
//     this.lineThickness = 2.0,
//     this.roundedCorners = false,
//     this.textDirection = TextDirection.ltr,
//     this.themeMode = ThemeMode.system,
//   });
//
//   factory SettingsState.fromPreferences(PreferenceProvider prefs) {
//     return const SettingsState().copyWith(
//       animateExpansions: prefs.getBool(animateExpansionsKey, false),
//       color: Color(prefs.getInt(colorKey, Colors.blue.value)),
//       connectBranches: prefs.getBool(connectBranchesKey, false),
//       indent: prefs.getDouble(indentKey),
//       indentGuideType: enumByName(
//           prefs.getString(indentGuideTypeKey), IndentGuideType.values),
//       lineOrigin: prefs.getDouble(lineOriginKey),
//       lineStyle: enumByName(prefs.getString(lineStyleKey), LineStyle.values),
//       lineThickness: prefs.getDouble(lineThicknessKey),
//       roundedCorners: prefs.getBool(roundedCornersKey, false),
//       textDirection:
//           enumByName(prefs.getString(textDirectionKey), TextDirection.values),
//       themeMode: enumByName(prefs.getString(themeModeKey), ThemeMode.values),
//     );
//   }
//
//   final bool animateExpansions;
//   final Color color;
//   final bool connectBranches;
//   final double indent;
//   final IndentGuideType indentGuideType;
//   final double lineOrigin;
//   final LineStyle lineStyle;
//   final double lineThickness;
//   final bool roundedCorners;
//   final TextDirection textDirection;
//   final ThemeMode themeMode;
//
//   SettingsState copyWith({
//     bool? animateExpansions,
//     Color? color,
//     bool? connectBranches,
//     double? indent,
//     IndentGuideType? indentGuideType,
//     double? lineOrigin,
//     LineStyle? lineStyle,
//     double? lineThickness,
//     bool? roundedCorners,
//     TextDirection? textDirection,
//     ThemeMode? themeMode,
//   }) {
//     return SettingsState(
//       animateExpansions: animateExpansions ?? this.animateExpansions,
//       color: color ?? this.color,
//       connectBranches: connectBranches ?? this.connectBranches,
//       indent: indent ?? this.indent,
//       indentGuideType: indentGuideType ?? this.indentGuideType,
//       lineOrigin: lineOrigin ?? this.lineOrigin,
//       lineStyle: lineStyle ?? this.lineStyle,
//       lineThickness: lineThickness ?? this.lineThickness,
//       roundedCorners: roundedCorners ?? this.roundedCorners,
//       textDirection: textDirection ?? this.textDirection,
//       themeMode: themeMode ?? this.themeMode,
//     );
//   }
// }
//
// const animateExpansionsKey = 'fftv.animateExpansions';
// const colorKey = 'fftv.color';
// const connectBranchesKey = 'fftv.connectBranches';
// const indentKey = 'fftv.indent';
// const indentGuideTypeKey = 'fftv.indentGuideType';
// const lineOriginKey = 'fftv.lineOrigin';
// const lineStyleKey = 'fftv.lineStyle';
// const lineThicknessKey = 'fftv.lineThickness';
// const roundedCornersKey = 'fftv.roundedCorners';
// const textDirectionKey = 'fftv.textDirection';
// const themeModeKey = 'fftv.themeMode';
