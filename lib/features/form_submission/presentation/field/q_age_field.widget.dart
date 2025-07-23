import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/custom_reactive_widget/age/reactive_age_field.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
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
        referenceDate: formInstance.entryStarted,
        enabled: element.elementControl.enabled,
        label: element.label,
        decoration: InputDecoration(
            enabled: element.elementControl.enabled,
            labelText: element.label,
            hintText: appLocator<HintProvider>().provideHint(element.type)));
  }
}
