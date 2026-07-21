import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveProgressSelectChip extends ConsumerWidget {
  QReactiveProgressSelectChip({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final formInstance = appLocator<FormInstance>();

    final progressStatuses =
        AssignmentStatus.values.where((v) => !v.isNotStarted()).toList();

    return ReactiveChoiceChips<String>(
      formControl: formInstance.form.control(element.elementPath!)
          as FormControl<String>,
      confirmChangingValue: element.dependents.length > 0,
      validationMessages: validationMessages(),
      options: _getChipOptions(progressStatuses),
      decoration: InputDecoration(
        enabled: element.elementControl.enabled,
        labelText: element.label,
      ),
      onChanged: (control) async {},
      // chipsPerRow: 2,
    );
  }

  List<ReactiveChipOption<String>> _getChipOptions(
      List<AssignmentStatus> teams) {
    return teams
        .map((AssignmentStatus status) => ReactiveChipOption<String>(
              value: status.name,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildStatusBadge(status),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Text(
                      Intl.message(status.name.toLowerCase()),
                      overflow: TextOverflow.ellipsis,
                    ))
                  ]),
            ))
        .toList();
  }
}
