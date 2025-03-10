import 'package:datarun/data_run/screens/form/element/form_element.dart';
import 'package:datarun/data_run/screens/form/element_widgets/field.widget.dart';
import 'package:datarun/data_run/screens/form/form_with_sliver/repeat_table/repeat_table_sliver.dart';
import 'package:datarun/data_run/screens/form/form_with_sliver/section.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:datarun/data_run/screens/form/element/providers/form_instance.provider.dart';
import 'package:datarun/data_run/screens/form/inherited_widgets/form_metadata_inherit_widget.dart';

class FormInstanceEntryViewSliver extends HookConsumerWidget {
  const FormInstanceEntryViewSliver({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    return CustomScrollView(
      shrinkWrap: true,
      controller: scrollController,
      slivers: buildSliverList(
          formInstance.formSection.elements.values, context, ref),
    );
  }

  List<Widget> buildSliverList(Iterable<FormElementInstance<dynamic>> elements,
      BuildContext context, WidgetRef ref) {
    return elements.map((element) {
      if (element is Section) {
        return SectionWidget(
          key: Key(element.elementPath!),
          element: element,
        );
      } else if (element is RepeatSection) {
        return RepeatTableSliver(
          key: Key('${element.elementPath!}_RepeatTableSliver'),
          repeatInstance: element,
        );
      } else if (element is FieldInstance) {
        return SliverToBoxAdapter(
          child: ListTile(
            title: FieldWidget(
              key: Key(element.elementPath!),
              element: element,
            ),
          ),
        );
      }
      return SliverToBoxAdapter(child: const SizedBox.shrink());
    }).toList();
  }

// Future<void> onAdd(BuildContext context, WidgetRef ref, int index, bool isNew,
//     RepeatInstance parent) async {
//   final formInstance = FormInstanceInheritWidget.of(context);
//
//   final elementInstance = parent.elements.elementAt(index);
//   final parentControl =
//       formInstance.form.control(parent.elementPath!) as FormArray;
//   final elementControl = parentControl.control('$index');
//
//   // await showModalBottomSheet(
//   //   isScrollControlled: true,
//   //   context: context,
//   //   builder: (BuildContext context) {
//   //     return FormMetadataWidget(
//   //       formMetadata: formMetadata,
//   //       child: EditPanel(
//   //         repeatItemInstance: elementInstance,
//   //         isNew: isNew,
//   //         onSave: () {
//   //           final validSaved =
//   //               formInstance.onSaveRepeatedItem(parent, elementInstance);
//   //           if (context.mounted && validSaved) Navigator.pop(context);
//   //         },
//   //         onCancel: () {
//   //           final validSaved = formInstance
//   //               .onRepeatItemAddCancel(parent, elementInstance, isNew: isNew);
//   //           if (context.mounted && validSaved) Navigator.pop(context);
//   //         },
//   //         onDelete: () {
//   //           formInstance.onRemoveRepeatedItem(index, parent);
//   //           if (context.mounted) Navigator.pop(context);
//   //         },
//   //         onSaveAndNew: () async {
//   //           final validSaved =
//   //               formInstance.onSaveRepeatedItem(parent, elementInstance);
//   //           if (context.mounted && validSaved) Navigator.pop(context);
//   //         },
//   //       ),
//   //     );
//   //   },
//   // );
// }
}

//
// class SectionHeader extends HookConsumerWidget {
//   const SectionHeader({super.key, required this.element});
//
//   final FormElementInstance<dynamic> element;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final elementPropertiesSnapshot = useStream(element.propertiesChanged);
//     if (!elementPropertiesSnapshot.hasData) {
//       return const CircularProgressIndicator();
//     }
//
//     if (element is FieldInstance) {
//       return SizedBox.shrink();
//     }
//
//     return Container(
//       height: 40.0,
//       color: elementPropertiesSnapshot.data!.errors.isNotEmpty
//           ? Colors.deepOrange
//           : Theme.of(context).primaryColor,
//       padding: EdgeInsets.symmetric(horizontal: 16.0),
//       alignment: Alignment.centerRight,
//       child: Text(
//         element.label,
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }
