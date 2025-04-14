import 'package:d_sdk/database/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'option_set_configuration.data.freezed.dart';

@freezed
sealed class OptionSetConfiguration with _$OptionSetConfiguration {
  const factory OptionSetConfiguration.defaultOptionSet(
      {required List<FormOption> options,
      @Default(<String>[]) List<String> optionsToHide,
      @Default(<String>[]) List<String> optionsToShow}) = DefaultOptionSet;

  const factory OptionSetConfiguration.bigOptionSet(
      {@Default(<FormOption>[]) List<FormOption> options,
      @Default(<String>[]) List<String> optionsToHide,
      @Default(<String>[]) List<String> optionsToShow}) = BigOptionSet;

  static OptionSetConfiguration config(
      int optionCount, List<FormOption> Function() optionRequestCallback) {
    return optionCount > 15
        ? const BigOptionSet()
        : OptionSetConfiguration.defaultOptionSet(
            options: optionRequestCallback());
  }

  OptionSetConfiguration updateOptionsToHideAndShow(
      {required List<String> optionsToHide,
      required List<String> optionsToShow}) {
    return setOptionsToHide(optionsToHide).setOptionsToShow(optionsToShow);
  }

  OptionSetConfiguration setOptionsToHide(List<String> optionsToHide) {
    return switch (this) {
      DefaultOptionSet defaultOptionSet =>
        defaultOptionSet.copyWith(optionsToHide: optionsToHide),
      BigOptionSet bigOptionSet =>
        bigOptionSet.copyWith(optionsToHide: optionsToHide),
    };
  }

  OptionSetConfiguration setOptionsToShow(List<String> optionsToShow) {
    return switch (this) {
      DefaultOptionSet defaultOptionSet =>
        defaultOptionSet.copyWith(optionsToShow: optionsToShow),
      BigOptionSet bigOptionSet =>
        bigOptionSet.copyWith(optionsToShow: optionsToShow),
    };
  }
}
