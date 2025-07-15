import 'package:datarunmobile/core/sync/model/sync_interval.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SyncSettingTabView extends HookConsumerWidget {
  const SyncSettingTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncMetadataRepo = appLocator<SyncMetadataRepository>();
    final selectedInterval = useState(syncMetadataRepo.getSyncInterval());
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(S.of(context).syncSettings,
            style: Theme.of(context).textTheme.titleLarge),

        Card(
          child: ListTile(
            leading: Icon(MdiIcons.update),
            title: Text(S.of(context).syncInterval),
            subtitle: DropdownButton<SyncInterval>(
              value: selectedInterval.value,
              items: SyncInterval.values.map((interval) {
                return DropdownMenuItem(
                  value: interval,
                  child: Text(Intl.message(interval.name)),
                );
              }).toList(),
              onChanged: (newInterval) async {
                if (newInterval != null) {
                  await syncMetadataRepo.setSyncInterval(newInterval);
                  selectedInterval.value = newInterval;
                }
              },
            ),
          ),
        ),

        const SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: Icon(Icons.check_circle,
                color: syncMetadataRepo.isInitialSyncDone
                    ? Colors.green
                    : Colors.red),
            title: Text(S.of(context).lastSyncStatus),
            subtitle: Text(syncMetadataRepo.isInitialSyncDone
                ? S.of(context).done
                : S.of(context).failed),
          ),
        ),

        // const SizedBox(height: 20),
        // Text(S.of(context).syncSummaryTitle,
        //     style: Theme.of(context).textTheme.titleMedium),

        // Show summary for *all* entities:
        // const SyncSummaryCard(),

        // Or, show just “formTemplates”:
        // const SyncSummaryCard(entityFilter: 'formTemplates'),
      ],
    );
  }
}
