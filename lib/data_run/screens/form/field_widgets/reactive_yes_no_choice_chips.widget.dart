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
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ReactiveYesNoChoiceChips extends ConsumerWidget {
  const ReactiveYesNoChoiceChips({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    return ReactiveChoiceChips<String>(
      formControl: formInstance.form.control(element.pathRecursive)
          as FormControl<String>,
      validationMessages: validationMessages(context),
      selectedColor: Theme.of(context).colorScheme.error.withAlpha(100),
      options: _getOptions(element.visibleOption, wide: false),
      // decoration: InputDecoration(
      //   // border: const OutlineInputBorder(gapPadding: 20),
      //   contentPadding: const EdgeInsets.all(16),
      //   labelText: element.label,
      // ),
    );
  }

  List<ReactiveChipOption<String>> _getOptions(List<FormOption> options,
      {bool? wide}) {
    return options
        .map((FormOption option) => ReactiveChipOption<String>(
              value: option.name,
              child: Container(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    children: <Widget>[
                      Text(getItemLocalString(option.label)),
                      Icon(
                        Icons.error,
                        size: 30,
                      ),
                    ],
                  )),
            ))
        .toList();
  }
}
