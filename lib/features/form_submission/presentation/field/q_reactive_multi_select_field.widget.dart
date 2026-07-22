import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:flutter/material.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveMultiSelectSearchField extends StatelessWidget {
  const QReactiveMultiSelectSearchField({super.key, required this.element});

  final FieldInstance<List<String>> element;

  @override
  Widget build(BuildContext context) {
    final formInstance = appLocator<FormInstance>();

    return ReactiveDropdownSearchMultiSelection<String, FormOption>(
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<List<String>>,
      validationMessages: validationMessages(),
      valueAccessor: FormOptionMultiSelectionValueAccessor(),
      dropdownDecoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
            labelText: element.label,
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            border: const OutlineInputBorder(),
            hintText: appLocator<HintProvider>().provideHint(element.type)),
      ),
      popupProps: const PopupPropsMultiSelection.menu(
        showSelectedItems: true,
      ),
      compareFn: (item, selectedItem) => item.code == selectedItem.code,
      itemAsString: (option) => option.displayName,
      items: (String filter, LoadProps? loadProps) => element.visibleOption,
    );
  }
}

class FormOptionMultiSelectionValueAccessor
    extends DropDownSearchMultiSelectionValueAccessor<String, FormOption> {
  @override
  List<FormOption>? modelToViewValue(
      List<FormOption> items, List<String>? modelValue) {
    return modelValue
        ?.map((value) => findFormOptionByValue(items, value))
        .whereType<FormOption>()
        .toList();
  }

  @override
  List<String>? viewToModelValue(
          List<FormOption> items, List<FormOption>? viewValue) =>
      viewValue?.map((option) => option.code).toList();
}
