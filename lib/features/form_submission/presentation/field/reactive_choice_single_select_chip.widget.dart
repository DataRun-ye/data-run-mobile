import 'package:d_sdk/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
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
        confirmChangingValue: element.dependents.length > 0,
        validationMessages: validationMessages(),
        options: _getChipOptions(element.visibleOption, wide: true),
        decoration: InputDecoration(
          enabled: element.elementControl.enabled,
          labelText: element.label,
        ));
  }

  List<ReactiveChipOption<String>> _getChipOptions(List<DataOption> options,
      {bool? wide}) {
    return options
        .map((DataOption option) => ReactiveChipOption<String>(
              value: option.name,
              child: wide ?? false
                  ? Container(
                      padding: const EdgeInsets.all(0.4),
                      child: Column(children: <Widget>[
                        Text(getItemLocalString(option.label))
                      ]))
                  : Text(getItemLocalString(option.label)),
            ))
        .toList();
  }
}
