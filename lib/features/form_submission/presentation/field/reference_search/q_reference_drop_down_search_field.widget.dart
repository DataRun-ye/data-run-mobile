import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/metadata_submission_update.dart';
import 'package:datarunmobile/data/metadata_submission_update.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element_validator/form_element_validator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

List<String> getFilteredData(
    String filter, List<MetadataSubmissionUpdate> data) {
  return data
      .where((item) {
        final lowerQuery = filter.toLowerCase();
        return item.formData['householdName']
                .toLowerCase()
                .contains(lowerQuery) ||
            item.formData['householdHeadSerialNumber']
                .toString()
                .contains(lowerQuery);
      })
      .map((item) => item.householdName!)
      .toList();
}

class QReferenceDropDownSearchField extends StatefulHookConsumerWidget {
  const QReferenceDropDownSearchField({super.key, required this.element});

  final FieldInstance<String> element;

  @override
  QReferenceDropDownSearchFieldState createState() =>
      QReferenceDropDownSearchFieldState();
}

class QReferenceDropDownSearchFieldState
    extends ConsumerState<QReferenceDropDownSearchField> {
  final _dropDownCustomBGKey = GlobalKey<DropdownSearchState<String>>();

  @override
  Widget build(BuildContext context) {
    final formInstance = appLocator<FormInstance>();

    final listValuesAsync = ref.watch(systemMetadataSubmissionsProvider(
        query: '', submissionId: formInstance.submissionId));

    return AsyncValueWidget(
      value: listValuesAsync,
      valueBuilder: (households) {
        return ReactiveDropdownSearch<String, String>(
          widgetKey: _dropDownCustomBGKey,
          formControl: formInstance.form.control(widget.element.elementPath!)
              as FormControl<String>,
          validationMessages: validationMessages(),
          dropdownDecoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: widget.element.label,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: const OutlineInputBorder(),
            ),
          ),
          items: (filter, t) => getFilteredData(filter, households),
          compareFn: (i, s) => i == s,
          popupProps: PopupProps.modalBottomSheet(
            showSelectedItems: true,
            showSearchBox: true,
            itemBuilder:
                (context, String item, bool isDisabled, bool isSelected) {
              final household =
                  households.where((t) => t.householdName == item).firstOrNull;
              return referenceModelPopupItem(
                  context, household, isDisabled, isSelected);
            },
          ),
        );
      },
    );
  }
}

Widget referenceModelPopupItem(BuildContext context,
    MetadataSubmissionUpdate? item, bool isDisabled, bool isSelected) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item?.householdName ?? 'No name'),
      leading: CircleAvatar(child: Text('${item?.householdHeadSerialNumber}')),
    ),
  );
}
