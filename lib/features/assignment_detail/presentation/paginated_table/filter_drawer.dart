import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/domain/filter.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/assignment_detail/application/table.providers.dart';
import 'package:datarunmobile/features/assignment_detail/application/table_controller.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FilterDrawer extends ConsumerWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Text('Status'),
          DropdownButtonFormField<InstanceSyncStatus>(
            items: InstanceSyncStatus.values
                .map((s) => DropdownMenuItem(
                      value: s,
                      child: Text(Intl.message(s.name).toUpperCase()),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                ref
                    .read(tableFilterProvider.notifier)
                    .addFilter(syncStatFilter(value));
                Navigator.pop(context);
              }
            },
          ),
          // Add date range filters similarly
        ],
      ),
    );
  }
}

FilterCondition syncStatFilter(InstanceSyncStatus status) {
  return FilterCondition.equals(DSdk.db.dataInstances.syncState, status.name);
}
