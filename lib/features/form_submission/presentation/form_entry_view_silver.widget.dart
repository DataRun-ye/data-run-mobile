import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormInstanceEntryViewSliver extends HookConsumerWidget {
  const FormInstanceEntryViewSliver({
    super.key,
    required this.scrollController,
    required this.submissionId,
  });

  final ScrollController scrollController;
  final String submissionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = appLocator<FormInstance>();

    List<Widget> buildSlivers() {
      return formInstance.formSection.elements.values.map((element) {
        if (element is Section) {
          return SectionWidget(element: element);
        } else if (element is RepeatSection) {
          return RepeatTableSliver(repeatInstance: element);
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
}
