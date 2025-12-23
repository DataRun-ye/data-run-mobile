import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QDropDownWithSearchField extends HookConsumerWidget {
  const QDropDownWithSearchField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return getAutoComplete(element.visibleOption, context, ref);
  }

  getAutoComplete(
      List<DataOption> options, BuildContext context, WidgetRef ref) {
    // final formInstance = ref
    //     .watch(
    //         formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
    //     .requireValue;
    final formInstance = appLocator<FormInstance>();

    return ReactiveDropdownSearch<String, String>(
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<String>,
      // clearButtonProps: const ClearButtonProps(isVisible: true),
      validationMessages: validationMessages(),
      valueAccessor: NameToLabelValueAccessor(options),
      dropdownDecoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: element.label,
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
          border: const OutlineInputBorder(),
        ),
      ),
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
      ),
      items: (filter, prop) => options
          .map((option) => getItemLocalString(option.label))
          .toSet()
          .toList(),
    );
  }
}

class NameToLabelValueAccessor
    extends DropDownSearchValueAccessor<String, String> {
  NameToLabelValueAccessor(this.options);

  final List<DataOption> options;

  @override
  String? modelToViewValue(List<String> items, String? modelValue) {
    return options
        .where((option) => option.code == modelValue || option.name == modelValue)
        .map((option) =>
            getItemLocalString(option.label, defaultString: option.name))
        .firstOrNull;
  }

  @override
  String? viewToModelValue(List<String> items, String? viewValue) {
    return options
        .where((option) =>
            getItemLocalString(option.label, defaultString: option.name) ==
            viewValue)
        .map((option) => option.code)
        .firstOrNull;
  }
}
