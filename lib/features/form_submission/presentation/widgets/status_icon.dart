import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusIcon extends StatelessWidget {
  const StatusIcon({
    super.key,
    required this.syncState,
  });

  final InstanceSyncStatus? syncState;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Intl.message(syncState?.name.toLowerCase() ?? '-'),
      child: switch (syncState) {
        InstanceSyncStatus.synced =>
          const Icon(Icons.cloud_done, color: Colors.green, size: 20),
        InstanceSyncStatus.finalized =>
          const Icon(Icons.cloud_upload, color: Colors.grey, size: 20),
        InstanceSyncStatus.draft =>
          Icon(Icons.edit_note, color: Colors.grey[500], size: 20),
        InstanceSyncStatus.syncFailed =>
          Icon(Icons.error, color: Colors.red, size: 20),
        _ => const SizedBox.shrink()
      },
    );
  }
}
