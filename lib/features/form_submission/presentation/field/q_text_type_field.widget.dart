import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_metadata_inherit_widget.dart';
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
        textAlign:
            element.template.type.isNumeric ? TextAlign.end : TextAlign.start,
        validationMessages: validationMessages(),
        decoration: InputDecoration(
          errorMaxLines: 2,
          enabled: control.enabled,
          labelText: element.label,
          hintText: appLocator<HintProvider>().provideHint(element.type)
        ));
  }
}
