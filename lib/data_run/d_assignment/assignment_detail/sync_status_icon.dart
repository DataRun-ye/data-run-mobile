import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:flutter/material.dart';

Widget buildStatusIcon(InstanceSyncStatus? status) {
  switch (status) {
    case InstanceSyncStatus.synced:
      return const Icon(Icons.cloud_done, color: Colors.green, size: 18);
    case InstanceSyncStatus.finalized:
      return const Icon(Icons.cloud_sync, color: Colors.grey, size: 18);
    case InstanceSyncStatus.draft:
      return Icon(Icons.update, color: Colors.grey[500], size: 18);
    case InstanceSyncStatus.syncFailed:
      return const Icon(Icons.error, color: Colors.red, size: 18);
    default:
      return const Icon(Icons.all_inclusive, size: 18);
  }
}

// Widget buildStatusIcon(SyncStatus? status, {bool colored = true}) {
//   switch (status) {
//     case SyncStatus.SYNCED:
//       return Icon(Icons.cloud_done,
//           color: colored ? Colors.green : Colors.grey, size: 18);
//     case SyncStatus.TO_POST:
//       return Icon(Icons.cloud_sync,
//           color: colored ? Colors.grey : Colors.grey, size: 18);
//     case SyncStatus.TO_UPDATE:
//       return Icon(Icons.update,
//           color: colored ? Colors.grey[500] : Colors.grey, size: 18);
//     case SyncStatus.ERROR:
//       return Icon(Icons.error,
//           color: colored ? Colors.red : Colors.grey, size: 18);
//     default:
//       return const Icon(Icons.all_inclusive, size: 18);
//   }
// }
