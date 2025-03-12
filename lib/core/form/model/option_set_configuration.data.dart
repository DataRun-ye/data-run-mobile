import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'option_set_configuration.data.freezed.dart';

@freezed
class OptionSetConfiguration with _$OptionSetConfiguration {
  const factory OptionSetConfiguration.defaultOptionSet(
      {required List<FormOption> options,
      @Default(<String>[]) List<String> optionsToHide,
      @Default(<String>[]) List<String> optionsToShow}) = DefaultOptionSet;

  const factory OptionSetConfiguration.bigOptionSet(
      {@Default(<FormOption>[]) List<FormOption> options,
      @Default(<String>[]) List<String> optionsToHide,
      @Default(<String>[]) List<String> optionsToShow}) = BigOptionSet;

  const OptionSetConfiguration._();

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
    return map(
        defaultOptionSet: (defaultOptionSet) =>
            defaultOptionSet.copyWith(optionsToHide: optionsToHide),
        bigOptionSet: (bigOptionSet) =>
            bigOptionSet.copyWith(optionsToHide: optionsToHide));
  }

  OptionSetConfiguration setOptionsToShow(List<String> optionsToShow) {
    return map(
        defaultOptionSet: (defaultOptionSet) =>
            defaultOptionSet.copyWith(optionsToShow: optionsToShow),
        bigOptionSet: (bigOptionSet) =>
            bigOptionSet.copyWith(optionsToShow: optionsToShow));
  }
}
