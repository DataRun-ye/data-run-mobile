import 'package:d_sdk/database/domain/filter.dart';
import 'package:datarunmobile/features/assignment_detail/application/table.providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterBar extends ConsumerWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(tableFilterProvider);

    return Wrap(
      spacing: 8,
      children: [
        ...filters.map((FilterCondition<Object> filter) => Chip(
              label: Text(filter.displayText),
              onDeleted: () =>
                  ref.read(tableFilterProvider.notifier).removeFilter(filter),
            )),
        IconButton(
          onPressed: () => Scaffold.of(context).openEndDrawer(),
          icon: const Icon(Icons.filter_list),
        ),
      ],
    );
  }
}
