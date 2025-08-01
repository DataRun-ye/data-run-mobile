import 'package:d_sdk/database/shared/assignment_status.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_chip_option.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_choice_chips.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveProgressSelectChip extends ConsumerWidget {
  QReactiveProgressSelectChip({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

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
                    // const SizedBox(width: 20),
                    Text(Intl.message(status.name.toLowerCase()))
                  ]),
            ))
        .toList();
  }

  Future<void> _confirmDelete(
      BuildContext context, String? status, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).confirm),
          content: Text(S.of(context).confirmationWarning),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(S.of(context).confirm),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final formInstance = ref
          .watch(formInstanceProvider(
              formMetadata: FormMetadataWidget.of(context)))
          .requireValue;

      formInstance.updateSubmissionStatus(AssignmentStatus.getType(status));
      // ref.read(assignmentsProvider.notifier).updateAssignmentStatus(
      //     AssignmentStatus.getType(status),
      //     formInstance.formMetadata.assignmentModel.id);
    }
  }
}
