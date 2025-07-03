import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/age/reactive_age_field.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QReactiveAgeField extends ConsumerWidget {
  QReactiveAgeField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    return ReactiveAgeField(
        formControl: formInstance.form.control(element.elementPath!)
            as FormControl<String>,
        validationMessages: validationMessages(),
        // displayDob: true,
        referenceDate: formInstance.entryStarted,
        enabled: element.elementControl.enabled,
        label: element.label,
        decoration: InputDecoration(
          enabled: element.elementControl.enabled,
          // border: const OutlineInputBorder(gapPadding: 20),
          // contentPadding: const EdgeInsets.all(16),
          labelText: element.label,
        ));
  }
}
