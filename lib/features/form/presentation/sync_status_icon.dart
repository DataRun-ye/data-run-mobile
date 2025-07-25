import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:flutter/material.dart';

Widget buildStatusIcon(InstanceSyncStatus? status) {
  switch (status) {
    case InstanceSyncStatus.synced:
      return const Icon(Icons.cloud_done, color: Colors.green, size: 18);
    case InstanceSyncStatus.finalized:
      return Icon(Icons.cloud_upload, color: Colors.grey[500], size: 18);
    case InstanceSyncStatus.draft:
      return Icon(Icons.edit_note, color: Colors.grey[500], size: 18);
    case InstanceSyncStatus.syncFailed:
      return Icon(Icons.error, color: Colors.red, size: 18);
    default:
      return const Icon(Icons.all_inclusive, size: 18);
  }
}
