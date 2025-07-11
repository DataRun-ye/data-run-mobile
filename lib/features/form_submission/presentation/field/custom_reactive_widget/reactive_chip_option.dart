import 'package:flutter/widgets.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_field_option.dart';

/// An option for filter chips.
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class ReactiveChipOption<T> extends ReactiveFieldOption<T> {
  /// Creates an option for fields with selection options
  const ReactiveChipOption({
    super.key,
    required super.value,
    this.avatar,
    super.child,
  });
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return child ?? Text(value.toString());
  }
}
