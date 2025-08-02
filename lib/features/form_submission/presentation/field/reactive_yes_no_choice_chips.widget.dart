import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveYesNoChoiceChips extends ConsumerWidget {
  const ReactiveYesNoChoiceChips({super.key, required this.element});

  final FieldInstance<bool> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = appLocator<FormInstance>();

    return ReactiveChoiceChips<bool>(
      formControl:
          formInstance.form.control(element.elementPath!) as FormControl<bool>,
      validationMessages: validationMessages(),
      confirmChangingValue: element.dependents.length > 0,
      options: _getChipOptions(context),
      decoration: InputDecoration(
        labelText: element.label,
      ),
    );
  }

  // Inside QReactiveSingleSelectField
  List<ReactiveChipOption<bool>> _getChipOptions(BuildContext context) {
    return [true, false].map((option) {
      // Find the longest label to determine a consistent width.
      // This is a simple, but effective heuristic. You might need a more
      // robust way to determine this for a large number of forms.
      // For now, let's just use a fixed width.
      const double chipMinWidth = 70.0; // Adjust this value as needed.

      return ReactiveChipOption<bool>(
        value: option,
        child: SizedBox(
          width: chipMinWidth,
          child: Text(
            option ? S.of(context).yes : S.of(context).no,
            textAlign: TextAlign.center,
            overflow:
                TextOverflow.ellipsis, // Prevent long text from overflowing
          ),
        ),
      );
    }).toList();
  }

  List<ReactiveChipOption<bool>> _getOptions(BuildContext context) {
    return [true, false]
        .map((option) => ReactiveChipOption<bool>(
              value: option,
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(option ? S.of(context).yes : S.of(context).no),
                    ],
                  )),
            ))
        .toList();
  }
}
