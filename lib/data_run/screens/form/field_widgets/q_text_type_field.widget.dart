import 'package:d2_remote/modules/datarun/form/shared/template_extensions/form_traverse_extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QTextTypeField<T> extends HookConsumerWidget {
  const QTextTypeField({super.key, required this.element});

  final FieldInstance<T> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    final control =
        formInstance.form.control(element.elementPath!) as FormControl<T>;

    return ReactiveTextField<T>(
        onTapOutside: control.hasFocus
            ? (event) {
                control.markAsTouched();
                control.unfocus();
              }
            : null,
        formControl: control,
        maxLength: element.maxLength,
        maxLines: element.maxLines,
        keyboardType: element.inputType,
        textAlign: element.template.isNumeric ? TextAlign.end : TextAlign.start,
        validationMessages: validationMessages(),
        decoration: InputDecoration(
          errorMaxLines: 2,
          enabled: control.enabled,
          labelText: element.label,
        ));
  }
}
