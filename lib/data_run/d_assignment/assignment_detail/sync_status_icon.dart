import 'package:datarunmobile/core/common/state.dart';
import 'package:flutter/material.dart';

Widget buildStatusIcon(SyncStatus? status) {
  switch (status) {
    case SyncStatus.SYNCED:
      return const Icon(Icons.cloud_done, color: Colors.green, size: 18);
    case SyncStatus.TO_POST:
      return const Icon(Icons.cloud_sync, color: Colors.grey, size: 18);
    case SyncStatus.TO_UPDATE:
      return Icon(Icons.update, color: Colors.grey[500], size: 18);
    case SyncStatus.ERROR:
      return const Icon(Icons.error, color: Colors.red, size: 18);
    default:
      return const Icon(Icons.all_inclusive, size: 18);
  }
}
