import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
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
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    final cs = Theme.of(context).colorScheme;

    return SliverStickyHeader(
        header: Container(
          color: headerColor ?? Theme.of(context).colorScheme.primary,
          // color: cs.primaryContainer,
          padding: const EdgeInsets.all(16),
          child: Text(element.label,
              style: TextStyle(
                  color: headerColor != null
                      ? cs.onPrimaryContainer
                      : cs.onPrimary)),
        ),
        sliver: MultiSliver(
          pushPinnedChildren: true,
          children: buildSliverList(element.elements.values, context),
        ));
  }

  List<Widget> buildSliverList(
      Iterable<FormElementInstance<dynamic>> elements, BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
