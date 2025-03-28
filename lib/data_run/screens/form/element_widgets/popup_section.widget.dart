import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data/form/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element_widgets/form_widget_factory.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PopupSectionWidget extends HookConsumerWidget {
  PopupSectionWidget({super.key, required this.element, String path = ''});

  final Section element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    return ReactiveForm(
      formGroup: formInstance.form.control(element.elementPath!) as FormGroup,
      child: Column(
        children: element.elements.values.map((childElement) {
          return PopupFormElementWidgetFactory.createWidget(childElement);
        }).toList(),
      ),
    );
  }
}
