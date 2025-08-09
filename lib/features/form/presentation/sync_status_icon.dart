import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:flutter/material.dart';

Widget buildStatusIcon(InstanceSyncStatus? status, [double size = 18.0]) {
  switch (status) {
    case InstanceSyncStatus.synced:
      return Icon(Icons.cloud_done, color: Colors.green, size: size);
    case InstanceSyncStatus.finalized:
      return Icon(Icons.cloud_upload, color: Colors.grey[500], size: size);
    case InstanceSyncStatus.draft:
      return Icon(Icons.edit_note, color: Colors.grey[500], size: size);
    case InstanceSyncStatus.syncFailed:
      return Icon(Icons.error, color: Colors.red, size: size);
    default:
      return Icon(Icons.all_inclusive, size: size);
  }
}
