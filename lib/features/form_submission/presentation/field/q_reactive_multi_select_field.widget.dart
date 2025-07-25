import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveMultiSelectSearchField extends HookConsumerWidget {
  const QReactiveMultiSelectSearchField({super.key, required this.element});

  final FieldInstance<List<String>> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    return ReactiveDropdownSearchMultiSelection<String, String>(
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<List<String>>,
      validationMessages: validationMessages(),
      // clearButtonProps: const ClearButtonProps(isVisible: true),
      // valueAccessor: NameToLabelValueAccessor(options: element.visibleOption),
      dropdownDecoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
            labelText: element.label,
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            border: const OutlineInputBorder(),
            hintText: appLocator<HintProvider>().provideHint(element.type)),
      ),
      popupProps: const PopupPropsMultiSelection.menu(
        showSelectedItems: false,
      ),
      compareFn: (item, selectedItem) => item == selectedItem,
      items: (String filter, LoadProps? loadProps) {
        return element.visibleOption
            .map((option) => getItemLocalString(option.label))
            .toSet()
            .toList();
      },
      // showClearButton: true,
    );
  }
}

class NameToLabelValueAccessor
    extends DropDownSearchMultiSelectionValueAccessor<String, String> {
  NameToLabelValueAccessor({this.items = const [], this.options = const []});

  final List<String> items;
  final List<DataOption> options;

  @override
  List<String>? modelToViewValue(List<String> items, List<String>? modelValue) {
    return options
        .where((option) => (modelValue?.contains(option.name) ?? false))
        .map((option) =>
            getItemLocalString(option.label, defaultString: option.name))
        .toList();
  }

  @override
  List<String>? viewToModelValue(List<String> items, List<String>? modelValue) {
    return options
        .where((option) =>
            modelValue?.contains(
                getItemLocalString(option.label, defaultString: option.name)) ==
            true)
        .map((option) => option.name)
        .toList();
  }
}
