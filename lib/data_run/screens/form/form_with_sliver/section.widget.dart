import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/element_widgets/field.widget.dart';
import 'package:datarunmobile/data_run/screens/form/form_with_sliver/repeat_table/repeat_table_sliver.dart';
import 'package:datarunmobile/data_run/screens/form/hooks/register_dependencies.dart';
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
    useRegisterDependencies(element);
    final elementState = useListenable(element.elementState);
    if (elementState.value.hidden) {
      return const SliverToBoxAdapter(child: null);
    }

    return SliverStickyHeader(
        header: Container(
          color: headerColor ?? Theme
              .of(context)
              .colorScheme
              .primary,
          padding: const EdgeInsets.all(16),
          child:
          Text(element.label, style: const TextStyle(color: Colors.white)),
        ),
        sliver: MultiSliver(
          pushPinnedChildren: true,
          children: buildSliverList(element.elements.values),
        ));
  }

  List<Widget> buildSliverList(
      Iterable<FormElementInstance<dynamic>> elements,) {
    return elements.map((element) {
      if (element is Section) {
        return SectionWidget(
          key: Key(element.elementPath!),
          element: element,
          headerColor: Colors.orange.shade600,
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
