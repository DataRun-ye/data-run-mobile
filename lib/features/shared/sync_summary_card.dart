import 'dart:convert';

import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class SyncSummaryCard extends HookConsumerWidget {
  const SyncSummaryCard({this.entityFilter, Key? key}) : super(key: key);

  /// The entity you want to show (e.g. 'activities', 'teams', or 'all')
  final String? entityFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(syncSummariesProvider);
    final syncMetadataRepo = appLocator<SyncMetadataRepository>();
    final lastSyncTime = syncMetadataRepo.lastSyncTime;
    String lastSynced = lastSyncTime != null
        ? timeago.format(lastSyncTime.toLocal(),
            locale: Intl.getCurrentLocale())
        : S.of(context).noSyncYet;

    return async.when(
      loading: () => Card(
          child: ListTile(
        leading: const CircularProgressIndicator(),
        title: Text(S.of(context).loading),
      )),
      error: (e, st) => Card(
          child: ListTile(
        leading: const Icon(Icons.error, color: Colors.red),
        title: Text(S.of(context).syncSummaryLoadError),
        subtitle: Text(e.toString()),
      )),
      data: (allSummaries) {
        // Optionally filter to a single entity:
        final summaries = entityFilter == null
            ? allSummaries
            : allSummaries.where((s) => s.entity == entityFilter).toList();

        if (summaries.isEmpty) {
          return Card(
              child: ListTile(
            leading: const Icon(Icons.sync),
            title: Text(S.of(context).noSyncsYet),
            subtitle: Text(S.of(context).performFirstSync),
          ));
        }

        // Show only the most‐recent one
        summaries.sort((a, b) => b.lastSync.compareTo(a.lastSync));
        final s = summaries.first;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Icon(
              s.failureCount > 0
                  ? Icons.error_outline
                  : Icons.check_circle_outline,
              color: s.failureCount > 0 ? Colors.red : Colors.green,
            ),
            subtitle: Text(
              '${S.of(context).lastSync}: ${lastSynced}\n'
              '${S.of(context).successCount}: ${s.successCount}\n'
              '${S.of(context).failureCount}: ${s.failureCount}',
            ),
            isThreeLine: true,
            trailing: s.errorsJson != null
                ? IconButton(
                    icon: const Icon(Icons.visibility),
                    tooltip: S.of(context).viewErrors,
                    onPressed: () {
                      final errors =
                          List<String>.from(jsonDecode(s.errorsJson!));
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(S.of(context).syncErrors),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: ListView(
                              shrinkWrap: true,
                              children:
                                  errors.map((e) => Text('• $e')).toList(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                  text: errors.join('\n'),
                                ));
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(S
                                          .of(context)
                                          .copiedToClipboard(
                                              S.of(context).errorSummary))),
                                );
                              },
                              child: Text(S.of(context).copyAll),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(S.of(context).close),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}

final syncSummariesProvider =
    StreamProvider.autoDispose<List<SyncSummary>>((ref) {
  ref.onDispose(() => logDebug('dispose syncSummariesProvider'));
  final dao = DSdk.db.syncSummariesDao;
  return dao.watchAllSummaries();
});
