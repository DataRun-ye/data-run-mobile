import 'package:datarunmobile/data/preference2.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';

class AppearanceSettingsTabViewmodel extends BaseViewModel {
  AppearanceSettingsTabViewmodel(this._ref);

  final Ref _ref;

  void toggleBrightness(bool value) {
    _ref
        .read(preferenceNotifierProvider(Preference.themeMode).notifier)
        .update(value ? ThemeMode.light.index : ThemeMode.dark.index);
  }

  void toggleUseMaterial3(bool value) {
    _ref
        .read(preferenceNotifierProvider(Preference.useMaterial3).notifier)
        .update(value);
  }

  void selectColorSeed(int value) {}
}
