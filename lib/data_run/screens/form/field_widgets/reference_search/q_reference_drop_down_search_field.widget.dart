import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/form_submission/metadata_submission_update.dart';
import 'package:datarunmobile/data/form_submission/metadata_submission_update.provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data/form/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/validation/form_element_validator.dart';
import 'package:datarunmobile/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';
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
  // return data
  //     .where((item) => item.userFilterBySerialName(filter))
  //     .map((item) => item.householdName ?? '')
  //     .toList();
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
    final formInstance = ref
        .watch(
        formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    // final orgUnitElement = formInstance.forElementMap.values
    //     .where((element) => element.type == ValueType.OrganisationUnit)
    //     .firstOrNull;

    // final ou = formInstance.formMetadata.assignmentModel.entityId;

    final listValuesAsync = ref.watch(systemMetadataSubmissionsProvider(
        query: '',
        orgUnit: formInstance.formMetadata.assignmentModel.entityId,
        submissionId: formInstance.submissionUid!));

    return AsyncValueWidget(
      value: listValuesAsync,
      valueBuilder: (households) {
        return ReactiveDropdownSearch<String, String>(
          widgetKey: _dropDownCustomBGKey,
          formControl: formInstance.form.control(widget.element.elementPath!)
          as FormControl<String>,
          validationMessages: validationMessages(),
          // valueAccessor: NameToLabelValueAccessor(households),
          dropdownDecoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: widget.element.label,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: const OutlineInputBorder(),
            ),
          ),
          // itemAsString: (metadata) =>
          //     '${metadata.householdName} ${metadata.householdName?.substring(0, 7)}',
          items: (filter, t) => getFilteredData(filter, households),
          compareFn: (i, s) => i == s,
          popupProps: PopupProps.modalBottomSheet(
            // containerBuilder: (ctx, popupWidget) {
            //   return Column(
            //     children: [
            //       Flexible(child: popupWidget),
            //       Row(
            //         mainAxisSize: MainAxisSize.min,
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.all(8),
            //             child: OutlinedButton(
            //               onPressed: () async {
            //                 _openAddNewForm(ctx, formInstance.submissionUid!,
            //                     orgUnitElement!.value);
            //                 _dropDownCustomBGKey.currentState
            //                     ?.closeDropDownSearch();
            //               },
            //               child: Text(S.of(context).addNew),
            //             ),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.all(8),
            //             child: OutlinedButton(
            //               onPressed: (_dropDownCustomBGKey.currentState
            //                               ?.getSelectedItems.length ??
            //                           0) >
            //                       0
            //                   ? () {
            //                       // How should I select all items in the list?
            //                       _dropDownCustomBGKey.currentState
            //                           ?.popupSelectAllItems();
            //                     }
            //                   : null,
            //               child: Text(S.of(context).edit),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   );
            // },
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

  // Future<void> _openAddNewForm(
  //     BuildContext context, String submissionId, String orgUnit) async {
  //
  //   return showDialog(
  //     context: context,
  //     builder: (_) => Dialog(
  //       child: AddMetadataSubmissionForm(
  //         onSubmit: (newItem) {
  //           // Handle adding new item to the dropdown's list
  //           ref
  //               .read(metadataSubmissionUpdatesProvider(orgUnit).notifier)
  //               .add(newItem);
  //           _dropDownCustomBGKey.currentState?.changeSelectedItem(newItem.id);
  //         },
  //         submissionId: submissionId,
  //         resourceId: orgUnit,
  //       ),
  //     ),
  //   );
  // }

  Widget buildDropdownItem(BuildContext context, MetadataSubmissionUpdate item,
      bool isDisabled, bool isSelected) {
    return Tooltip(
      message:
      'Household: ${item.householdName}\n Serial: ${item.householdHeadSerialNumber}',
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.white,
          border: isSelected
              ? Border.all(color: Colors.blue, width: 2.0)
              : Border.all(color: Colors.grey[300]!),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Text(
          item.householdName ?? 'no name',
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
//
// Widget buildModalFooter(
//     BuildContext context, MetadataSubmissionUpdate? selectedItem) {
//   return Container(
//     color: Colors.grey[200],
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ElevatedButton.icon(
//           onPressed: () => _openAddNewForm(context),
//           icon: const Icon(Icons.add),
//           label: const Text("Add New"),
//         ),
//         if (selectedItem != null)
//           ElevatedButton.icon(
//             onPressed: () => _openEditForm(context, selectedItem),
//             icon: const Icon(Icons.edit),
//             label: const Text("Edit"),
//           ),
//       ],
//     ),
//   );
// }
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

class NameToLabelValueAccessor
    extends DropDownSearchValueAccessor<String, String> {
  NameToLabelValueAccessor(this.metadataUpdates);

  final List<MetadataSubmissionUpdate> metadataUpdates;

  @override
  String? modelToViewValue(List<String> items, String? modelValue) {
    return metadataUpdates
        .where((item) => item.id == modelValue)
        .firstOrNull
        ?.householdName;
  }

  @override
  String? viewToModelValue(List<String> items, String? viewValue) {
    // return viewValue?.id;
    return metadataUpdates
        .where((item) => item.householdName == viewValue)
        .map((t) => t.id)
        .firstOrNull;
  }
}
