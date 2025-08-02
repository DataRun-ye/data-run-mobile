import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QSwitchField extends ConsumerWidget {
  const QSwitchField({super.key, required this.element});

  final FieldInstance<bool> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final formInstance = ref
    //     .watch(
    //         formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
    //     .requireValue;
    final formInstance = appLocator<FormInstance>();

    return Row(
      children: [
        Expanded(child: Text('${element.label}')),
        ReactiveCheckbox(
          tristate: true,
          formControl: formInstance.form.control(element.elementPath!)
              as FormControl<bool>,
        )
      ],
    );
  }
}
