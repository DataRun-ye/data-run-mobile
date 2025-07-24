import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SectionWidget extends HookConsumerWidget {
  SectionWidget({
    super.key,
    required this.element,
    Color? headerColor,
  }) : this.headerColor = headerColor;

  final Section element;
  final Color? headerColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elementPropertiesSnapshot = useStream(element.propertiesChanged);

    if (!elementPropertiesSnapshot.hasData) {
      return const SliverToBoxAdapter(child: CircularProgressIndicator());
    }

    if (elementPropertiesSnapshot.data!.hidden) {
      return const SliverToBoxAdapter();
    }
    final cs = Theme.of(context).colorScheme;

    return SliverStickyHeader(
        header: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: headerColor ?? Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(16),
            child: Text(element.label,
                style: TextStyle(
                    color: headerColor != null
                        ? cs.onPrimaryContainer
                        : cs.onPrimary)),
          ),
        ),
        sliver: SliverPadding(
          padding: const EdgeInsets.only(top: 8),
          sliver: MultiSliver(
            pushPinnedChildren: true,
            children: buildSliverList(element.elements.values, context, ref),
          ),
        ));
  }

  List<Widget> buildSliverList(Iterable<FormElementInstance<dynamic>> elements,
      BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final FormInstance formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    return elements.map((element) {
      if (element is Section) {
        return SectionWidget(
          key: Key(element.elementPath!),
          element: element,
          headerColor: cs.primaryContainer,
        );
      } else if (element is RepeatSection) {
        return RepeatTableSliver(
          key: Key('${element.elementPath!}_RepeatTableSliver'),
          repeatInstance: element,
        );
      } else if (element is FieldInstance) {
        return FieldWidget(
            key: formInstance.fieldKeysRegistery
                .getOrCreateKey(element.elementPath!),
            element: element);
      }
      return const SliverToBoxAdapter();
    }).toList();
  }
}
