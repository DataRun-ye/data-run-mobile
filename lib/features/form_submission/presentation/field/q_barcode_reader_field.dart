import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/form/ui/factories/hint_provider.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/code_scanner/reactive_code_scan_field.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QBarcodeReaderField<T> extends ConsumerWidget {
  const QBarcodeReaderField({Key? key, required this.element})
      : super(key: key);
  final FieldInstance<T> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    final control =
        formInstance.form.control(element.elementPath!) as FormControl<T>;

    return ReactiveCodeScanField<T>(
        formControl: control,
        validationMessages: validationMessages(),
        decoration: InputDecoration(
            // prefixIcon: ,
            enabled: control.enabled,
            labelText: element.label,
            hintText: appLocator<HintProvider>().provideHint(element.type)));
  }
}
