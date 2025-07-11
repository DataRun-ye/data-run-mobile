import 'package:datarunmobile/data/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_metadata_inherit_widget.dart';
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
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }).toList();
  }
}
