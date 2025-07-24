import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormInstanceEntryViewSliver extends HookConsumerWidget {
  const FormInstanceEntryViewSliver({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FormInstance formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    List<Widget> buildSlivers() {
      return formInstance.formSection.elements.values.map((element) {
        if (element is Section) {
          return SectionWidget(
            // key: key, linked to the nested child table
            element: element,
          );
        } else if (element is RepeatSection) {
          return RepeatTableSliver(
            // key: key, linked to the nested child table
            repeatInstance: element,
          );
        } else if (element is FieldInstance) {
          return FieldWidget(
              key: appLocator<FieldContextRegistry>()
                  .getOrCreateKey(element.elementPath!),
              element: element);
        }
        return const SliverToBoxAdapter();
      }).toList();
    }

    return CustomScrollView(
      shrinkWrap: true,
      controller: scrollController,
      slivers: buildSlivers(),
    );
  }

//
// /*List<Widget>*/
//
// buildSlivers(
//     FormInstance formInstance,
//     WidgetRef ref,
//     ) {
//   final ff = formInstance.forElementMap.values.map((element) {
//     final propsAsync = ref.watch(elementPropertiesStreamProvider(
//         path: element.elementPath!, formMetadata: formInstance.formMetadata));
//     return AsyncValueWidget(
//       value: propsAsync,
//       valueBuilder: (FormElementState elementState) {
//         if (elementState.hidden) {
//           return const SliverToBoxAdapter(child: SizedBox.shrink());
//         }
//         if (element is FieldInstance) {
//           final key = formInstance.fieldKeysRegistery
//               .getOrCreateKey(element.elementPath!);
//           return SliverToBoxAdapter(
//             key: key,
//             child: ListTile(
//               title: FieldWidget(key: key, element: element),
//             ),
//           );
//         }
//         return SizedBox();
//       },
//       isLoadingBuilder: () =>
//           SliverToBoxAdapter(child: CircularProgressIndicator()),
//       errorBuilder: (error, st) =>
//           SliverToBoxAdapter(child: getErrorWidget(error, st)),
//     );
//
//     propsAsync.when(
//       loading: () => SliverToBoxAdapter(child: CircularProgressIndicator()),
//       error: (_, __) => SliverToBoxAdapter(child: SizedBox.shrink()),
//       data: (props) {
//         if (props.hidden) {
//           return const SliverToBoxAdapter(child: SizedBox.shrink());
//         }
//
//         // otherwise build exactly one sliver for this element:
//         if (element is FieldInstance) {
//           final key = formInstance.fieldKeysRegistery
//               .getOrCreateKey(element.elementPath!);
//           return SliverToBoxAdapter(
//             key: key,
//             child: ListTile(
//               title: FieldWidget(key: key, element: element),
//             ),
//           );
//         }
//         // …sections, repeats, etc…
//       },
//     );
//   }).toList();
// }
}
