import 'package:flutter/widgets.dart';
import 'package:mass_pro/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_field_option.dart';

/// An option for filter chips.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class ReactiveChipOption<T> extends ReactiveFieldOption<T> {
  final Widget? avatar;

  /// Creates an option for fields with selection options
  const ReactiveChipOption({
    super.key,
    required super.value,
    this.avatar,
    super.child,
  });

  @override
  Widget build(BuildContext context) {
    return child ?? Text(value.toString());
  }
}