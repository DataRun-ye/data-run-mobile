import 'package:d2_remote/modules/datarun/form/shared/form_option.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarun/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:datarun/core/utils/get_item_local_string.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveChoiceSingleSelectChips extends ConsumerWidget {
  QReactiveChoiceSingleSelectChips({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    return ReactiveChoiceChips<String>(
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<String>,
      validationMessages: validationMessages(),
      selectedColor: Theme.of(context).colorScheme.error.withAlpha(100),
      options: _getChipOptions(element.visibleOption, wide: true),
      decoration: InputDecoration(
        enabled: element.elementControl.enabled,
        // border: const OutlineInputBorder(gapPadding: 20),
        // contentPadding: const EdgeInsets.all(16),
        labelText: element.label,

      )
    );
  }

  List<ReactiveChipOption<String>> _getChipOptions(List<FormOption> options,
      {bool? wide}) {
    return options
        .map((FormOption option) => ReactiveChipOption<String>(
              value: option.name,
              child: wide ?? false
                  ? Container(
                      padding: const EdgeInsets.all(0.4),
                      child: Column(children: <Widget>[
                        Text(getItemLocalString(option.label.unlockView))
                      ]))
                  : Text(getItemLocalString(option.label.unlockView)),
            ))
        .toList();
  }
}
