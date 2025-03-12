import 'package:flutter/material.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/model/tree_node_data_source.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/org_unit_picker/org_unit_picker_field.widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveOuPicker<T> extends ReactiveFormField<T, String> {
  ReactiveOuPicker({
    super.key,
    super.valueAccessor,
    super.showErrors,
    super.validationMessages,
    super.focusNode,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool canRequestFocus = true,
    bool showClearButton = false,
    double disabledOpacity = 0.5,
    String? formControlName,
    FormControl<T>? formControl,
    ReactiveFormFieldCallback<T>? onChanged,
    required TreeNodeDataSource dataSource,
  }) : super(
          formControl: formControl,
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<T, String> field) {
            Widget? prefixIcon =
                decoration?.prefixIcon ?? const Icon(Icons.account_tree);

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(prefixIcon: prefixIcon);

            ;
            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
                child: GestureDetector(
                  onTap: () {},
                  child: OrgUnitPickerField(
                    initialValueUid: field.value,
                    decoration: effectiveDecoration.copyWith(
                      errorText: field.errorText,
                      enabled: field.control.enabled,
                    ),
                    onChanged: (value) {
                      field.didChange(value);
                      onChanged?.call(field.control);
                    },
                    validator: (value) => validationMessages?.keys.first,
                    // errorInvalidText: validationMessages?.keys.first,
                    onSubmitted: field.didChange,
                    dataSource: dataSource,
                  ),
                ),
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      ReactiveFormFieldState<T, String>();
}
