import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form/presentation/sync_status_icon.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({
    super.key,
    required this.filter,
  });

  final SubmissionsFilter filter;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late SubmissionsFilter filter;

  @override
  void initState() {
    super.initState();
    filter = widget.filter;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            controller: scrollController,
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
                    tooltip: Intl.message(status.name),
                    selectedColor: theme.colorScheme.secondary,
                    label: buildStatusIcon(status),
                    selected: isSelected,
                    onSelected: (value) => setState(() => filter =
                        filter.toggleSyncStatus(isSelected ? null : status)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              _buildDateRangeDropdown(),
              const SizedBox(height: 16),
              _buildIncludeDeletedCheckbox(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(widget.filter);
                    },
                    child: Text(S.of(context).cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(S.of(context).clear),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // widget.onApply(filter);
                      Navigator.of(context).pop(filter);
                    },
                    child: Text(S.of(context).apply),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDateRangeDropdown() {
    return DropdownButtonFormField<DateFilterBand?>(
      decoration: InputDecoration(labelText: S.of(context).dateRange),
      value: filter.dateFilterBand,
      items: [
        DropdownMenuItem(value: null, child: Text(S.of(context).allDates)),
        ...DateFilterBand.values.map((band) => DropdownMenuItem(
            value: band, child: Text(Intl.message(band.name)))),
      ],
      onChanged: (value) {
        setState(() {
          filter = filter.copyWith(dateFilterBand: value);
        });
      },
    );
  }

  Widget _buildIncludeDeletedCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: filter.includeDeleted,
          onChanged: (value) {
            setState(() {
              filter = filter.copyWith(includeDeleted: value);
            });
          },
        ),
        Text(S.of(context).includeDeleted),
      ],
    );
  }
}
