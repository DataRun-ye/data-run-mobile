import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/user_org_units.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/reactive_org_unit_picker.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveOrgUnitSelectField extends HookConsumerWidget {
  const QReactiveOrgUnitSelectField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    final userOrgUnits = ref.watch(userOrgUnitsProvider(
        formInstance.formMetadata.assignmentModel.activity!.id));

    return AsyncValueWidget(
      value: userOrgUnits,
      valueBuilder: (orgUnits) => ReactiveOrgUnitPicker(
        formControl: formInstance.form.control(element.elementPath!)
            as FormControl<String>,
        validationMessages: validationMessages(),
        singleChoice: true,
        leafIds: orgUnits.map((o) => o.id).toList(),
        initialData: element.value,
        decoration: InputDecoration(labelText: element.label),
      ),
    );
  }
}
