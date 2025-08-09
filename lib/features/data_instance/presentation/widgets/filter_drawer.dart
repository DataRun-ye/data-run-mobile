import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/features/form/presentation/sync_status_icon.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({
    super.key,
    required this.formId,
    this.assignmentId,
  });

  final String formId;
  final String? assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filter = ref.watch(dataInstanceFilterProvider(
      formId: formId,
      assignmentId: assignmentId,
    ));
    return Drawer(
      width: 265.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.elliptical(40, 16),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 60),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).filters,
                      style: theme.textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 12),
              Text(S.of(context).status, style: theme.textTheme.titleMedium),
              const SizedBox(height: 6),
              Wrap(
                spacing: 0,
                children: InstanceSyncStatus.values.map((status) {
                  final isSelected = filter.syncState == status;
                  return FilterChip(
                    showCheckmark: false,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    tooltip: Intl.message(status.name),
                    selectedColor: DColors.CustomYellow,
                    label: buildStatusIcon(status),
                    selected: isSelected,
                    onSelected: (value) {
                      ref
                          .read(dataInstanceFilterProvider(
                                  formId: formId, assignmentId: assignmentId)
                              .notifier)
                          .toggleSyncStatus(isSelected ? null : status);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              _buildDateRangeDropdown(context, filter, ref),
              const SizedBox(height: 16),
              _buildIncludeDeletedCheckbox(context, filter, ref),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: ref
                        .read(dataInstanceFilterProvider(
                                formId: formId, assignmentId: assignmentId)
                            .notifier)
                        .clear,
                    child: Text(S.of(context).clear),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeDropdown(
      BuildContext context, SubmissionsFilter filter, WidgetRef ref) {
    return DropdownButtonFormField<DateFilterBand?>(
      decoration: InputDecoration(labelText: S.of(context).dateRange),
      value: filter.dateFilterBand,
      items: [
        DropdownMenuItem(value: null, child: Text(S.of(context).allDates)),
        ...DateFilterBand.values.map((band) => DropdownMenuItem(
            value: band, child: Text(Intl.message(band.name)))),
      ],
      onChanged: (value) {
        ref
            .read(dataInstanceFilterProvider(
                    formId: formId, assignmentId: assignmentId)
                .notifier)
            .toggleDateBand(value);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildIncludeDeletedCheckbox(
      BuildContext context, SubmissionsFilter filter, WidgetRef ref) {
    return SwitchListTile(
        dense: true,
        title: Text(S.of(context).includeDeleted),
        value: filter.includeDeleted,
        onChanged: (value) {
          ref
              .read(dataInstanceFilterProvider(
                      formId: formId, assignmentId: assignmentId)
                  .notifier)
              .toggleIncludeDeleted(value);
          Navigator.pop(context);
        });
  }
}

FilterCondition syncStatFilter(InstanceSyncStatus status) {
  return FilterCondition.equals(DSdk.db.dataInstances.syncState, status.name);
}
