import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:datarunmobile/features/data_instance/presentation/widgets/filter_badge.dart';
import 'package:datarunmobile/features/form/presentation/sync_status_icon.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FilterBar extends ConsumerWidget {
  FilterBar({
    super.key,
    required this.formId,
    this.assignmentId,
  });

  final String formId;
  final String? assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(
        dataInstanceFilterProvider(formId: formId, assignmentId: assignmentId));
    final List<Widget> filterChips = [];

    if (filter.syncState != null) {
      filterChips.add(Chip(
        label: buildStatusIcon(filter.syncState, 20),
        deleteIcon: const Icon(Icons.close),
        onDeleted: () {
          ref
              .read(dataInstanceFilterProvider(
                      formId: formId, assignmentId: assignmentId)
                  .notifier)
              .toggleSyncStatus(null);
        },
      ));
    }

    // Date Range Chip
    if (filter.dateFilterBand != null) {
      filterChips.add(Chip(
        label: Text('${Intl.message(filter.dateFilterBand!.name)}'),
        deleteIcon: const Icon(Icons.close),
        onDeleted: () {
          ref
              .read(dataInstanceFilterProvider(
                      formId: formId, assignmentId: assignmentId)
                  .notifier)
              .toggleDateBand(null);
        },
      ));
    }

    // Include Deleted Chip
    if (filter.includeDeleted) {
      filterChips.add(Chip(
        label: Text(S.of(context).includeDeleted),
        deleteIcon: const Icon(Icons.close),
        onDeleted: () {
          ref
              .read(dataInstanceFilterProvider(
                      formId: formId, assignmentId: assignmentId)
                  .notifier)
              .toggleIncludeDeleted(false);
        },
      ));
    }

    return Wrap(
      spacing: 8,
      children: [
        ...filterChips,
        FilterBadge(
          count: filter.filterCount,
          onTap: () => Scaffold.of(context).openEndDrawer(),
        ),
      ],
    );
  }
}
