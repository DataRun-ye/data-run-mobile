import 'package:datarunmobile/data/assignment/assignment.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActiveFiltersWidget extends ConsumerWidget {
  const ActiveFiltersWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> activeFilters = ref.watch(filterQueryProvider
        .select((assignmentFilter) => assignmentFilter.filters));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          if (activeFilters.isNotEmpty)
            ActionChip(
              avatar: const Icon(Icons.clear_all),
              tooltip: S.of(context).clearAll,
              label: Text(S.of(context).clearAll),
              onPressed: ref.read(filterQueryProvider.notifier).clearAllFilters,
            ),
          for (var entry in activeFilters.entries)
            Chip(
              label: Text('${entry.key}: ${entry.value}'),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => ref
                  .read(filterQueryProvider.notifier)
                  .removeFilter(entry.key),
            ),
        ],
      ),
    );
  }
}

class FilterModel {
  FilterModel({
    required this.label,
    required this.options,
    this.isMultiSelect = false,
    this.icon,
  });

  final String label;
  final List<String> options;
  final bool isMultiSelect;
  final IconData? icon;
}
