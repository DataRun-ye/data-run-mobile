import 'package:datarunmobile/data_run/screens/form/element/form_element.dart';
import 'package:datarunmobile/data_run/screens/form/form_with_sliver/repeat_table.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RepeatTableSliver extends HookConsumerWidget {
  const RepeatTableSliver({
    super.key,
    required this.repeatInstance,
  });

  final RepeatSection repeatInstance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final elementPropertiesSnapshot =
        useStream(repeatInstance.propertiesChanged);

    if (!elementPropertiesSnapshot.hasData) {
      return const SliverToBoxAdapter(child: CircularProgressIndicator());
    }

    if (elementPropertiesSnapshot.data!.hidden) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverStickyHeader(
      header: Container(
        color: Colors.black45,
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(MdiIcons.table),
          Expanded(
            child: Text(repeatInstance.label, softWrap: true),
          )
        ]),
      ),
      sliver: SliverToBoxAdapter(
        child: Scrollbar(
          child: RepeatTable(
            key: Key(repeatInstance.elementPath!),
            repeatInstance: repeatInstance,
          ),
        ),
      ),
    );
  }
}
