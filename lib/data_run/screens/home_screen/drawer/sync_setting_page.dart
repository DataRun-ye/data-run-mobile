import 'package:d2_remote/modules/datarun_shared/sync/call/d2_progress.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/core/sync_manager/nmc_worker/sync_progress.dart';
import 'package:datarun/core/sync_manager/sync_service.dart';
import 'package:datarun/data_run/screens/sync_screen/sync_screen.widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SyncSettingTab extends HookConsumerWidget {
  const SyncSettingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncService = ref.watch(syncServiceProvider.notifier);
    final selectedInterval = useState(syncService.getSyncInterval());
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(S.of(context).syncSettings,
            style: Theme.of(context).textTheme.titleLarge),

        Card(
          child: ListTile(
            leading: Icon(MdiIcons.update, ),
            title: Text(S.of(context).syncInterval),
            subtitle: DropdownButton<SyncInterval>(
              value: selectedInterval.value,
              items: SyncInterval.values.map((interval) {
                return DropdownMenuItem(
                  value: interval,
                  child: Text(interval.localLabel),
                );
              }).toList(),
              onChanged: (newInterval) async {
                if (newInterval != null) {
                  await syncService.setSyncInterval(newInterval);
                  selectedInterval.value = newInterval;
                }
              },
            ),
          ),
        ),

        const SizedBox(height: 10),

        Card(
          child: ListTile(
            title: Text(S.of(context).lastConfigurationSyncTime),
            subtitle: Text(
                ref.watch(userSessionManagerProvider).lastSyncTime.toString()),
            trailing: FilledButton(
                onPressed: () {
                  ref.read(syncServiceProvider.notifier).performSync(
                        onFinish: (message) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message ?? '')),
                        ),
                      );
                },
                child: Text(S.of(context).syncNow)),
          ),
        ),
        // Sync Status Card
        Card(
          child: ListTile(
            leading: Icon(Icons.check_circle,
                color: ref.watch(userSessionManagerProvider).syncDone
                    ? Colors.green
                    : Colors.red),
            title: Text(S.of(context).lastSyncStatus),
            subtitle: Text(ref.watch(userSessionManagerProvider).syncDone
                ? S.of(context).done
                : S.of(context).failed),
          ),
        ),
      ],
    );
  }
}
