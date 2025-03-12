import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QSwitchField extends ConsumerWidget {
  const QSwitchField({super.key, required this.element});

  final FieldInstance<bool> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

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
