import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarunmobile/data/ou_picker_data_source.provider.dart';
import 'package:datarunmobile/data_run/screens/form/field_widgets/custom_reactive_widget/reactive_o_u_picker.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class QOrgUnitPickerField extends HookConsumerWidget {
  const QOrgUnitPickerField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataSourceAsyncValue = ref.watch(ouPickerDataSourceProvider(
        formMetadata: FormMetadataWidget.of(context)));

    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    return AsyncValueWidget(
      value: dataSourceAsyncValue,
      valueBuilder: (dataSource) => ReactiveOuPicker(
        formControl: formInstance.form.control(element.elementPath!)
            as FormControl<String>,
        validationMessages: validationMessages(),
        decoration: InputDecoration(labelText: element.label),
        dataSource: dataSource,
      ),
    );
  }
}
