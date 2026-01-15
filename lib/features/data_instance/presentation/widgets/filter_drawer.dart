import 'dart:math' as math;

import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
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
    final colorScheme = theme.colorScheme;
    final filter = ref.watch(dataInstanceFilterProvider(
      formId: formId,
      assignmentId: assignmentId,
    ));
    final tableAppearance = ref.watch(tableAppearanceControllerProvider);

    final drawerWidth =
        math.min(290.0, MediaQuery.of(context).size.width * 0.85);

    return Drawer(
      width: drawerWidth,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.horizontal(
          right: Radius.elliptical(40, 16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).tableControl,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip:
                        MaterialLocalizations.of(context).closeButtonTooltip,
                    onPressed: () => Navigator.of(context).pop(),
                    icon:
                        Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // --- TABLE APPEARANCE moved to top ---
              Text(S.of(context).tableAppearance,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),

              Card(
                elevation: 0,
                color: colorScheme.surfaceContainerHigh,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      dense: true,
                      title: Text(S.of(context).fixedTableColumns),
                      value: tableAppearance.fixedActionColumns,
                      onChanged: (value) {
                        ref
                            .read(tableAppearanceControllerProvider.notifier)
                            .toggleFixedActionColumns(value);
                        // Navigator.pop(context);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      visualDensity: VisualDensity.compact,
                    ),
                    const Divider(height: 1),
                    CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      dense: true,
                      title: Text(S.of(context).compactTable),
                      value: tableAppearance.compact,
                      onChanged: (value) {
                        ref
                            .read(tableAppearanceControllerProvider.notifier)
                            .toggleCompact(value);
                        // Navigator.pop(context);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      visualDensity: VisualDensity.compact,
                    ),
                    const Divider(height: 1),
                    CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      dense: true,
                      title: Text(S.of(context).hiddenSpeedDialIssueChangeDirection),
                      value: tableAppearance.upwardDirectionOfSpeedDial,
                      onChanged: (value) {
                        ref
                            .read(tableAppearanceControllerProvider.notifier)
                            .toggleDirectionOfSpeedDial(value);
                        // Navigator.pop(context);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Divider(color: theme.dividerColor),
              const SizedBox(height: 12),

              Text(S.of(context).filters,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600, )),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                color: null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Column(
                    children: [
                      _buildDateRangeDropdown(context, filter, ref),
                      // const SizedBox(height: 12),
                      // _buildIncludeDeletedCheckbox(context, filter, ref),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Card(
                elevation: 0,
                color: colorScheme.surfaceContainerHigh,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).status,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 8,
                        children: InstanceSyncStatus.values
                            .where((v) =>
                        v.isFilterIcon &&
                            // hide the Synced chip when hideSynced is enabled
                            !(tableAppearance.hideSynced &&
                                v.name.toLowerCase() == 'synced'))
                            .map((status) {
                          final isSelected = filter.syncStates.contains(status);
                          return FilterChip(
                            showCheckmark: false,
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            tooltip: Intl.message(status.name),
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 8),
                            label: buildStatusIcon(status),
                            selected: isSelected,
                            selectedColor: Colors.orange[200],
                            backgroundColor: colorScheme.surface,
                            side: isSelected
                                ? BorderSide(
                                color: colorScheme.primary, width: 1)
                                : BorderSide(color: colorScheme.outline),
                            labelStyle: theme.textTheme.bodySmall?.copyWith(
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurface),
                            onSelected: (value) {
                              // toggle membership in the set
                              ref
                                  .read(dataInstanceFilterProvider(
                                  formId: formId,
                                  assignmentId: assignmentId)
                                  .notifier)
                                  .toggleSyncStatus(status);
                              // Navigator.pop(context);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Divider(color: theme.dividerColor),
              const SizedBox(height: 12),
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(dataInstanceFilterProvider(
                          formId: formId, assignmentId: assignmentId)
                          .notifier)
                          .clear();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      textStyle: theme.textTheme.labelLarge,
                    ),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return DropdownButtonFormField<DateFilterBand?>(
      decoration: InputDecoration(
        labelText: S.of(context).dateRange,
        isDense: true,
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
      ),
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
        // Navigator.pop(context);
      },
    );
  }

  Widget _buildIncludeDeletedCheckbox(
      BuildContext context, SubmissionsFilter filter, WidgetRef ref) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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
      },
      controlAffinity: ListTileControlAffinity.leading,
      visualDensity: VisualDensity.compact,
    );
  }
}

FilterCondition syncStatFilter(InstanceSyncStatus status) {
  return FilterCondition.equals(DSdk.db.dataInstances.syncState, status.name);
}
