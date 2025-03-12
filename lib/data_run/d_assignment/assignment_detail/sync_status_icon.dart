import 'package:datarunmobile/core/common/state.dart';
import 'package:flutter/material.dart';

Widget buildStatusIcon(SyncStatus? status, {bool colored = true}) {
  switch (status) {
    case SyncStatus.SYNCED:
      return Icon(Icons.cloud_done,
          color: colored ? Colors.green : Colors.grey, size: 18);
    case SyncStatus.TO_POST:
      return Icon(Icons.cloud_sync,
          color: colored ? Colors.grey : Colors.grey, size: 18);
    case SyncStatus.TO_UPDATE:
      return Icon(Icons.update,
          color: colored ? Colors.grey[500] : Colors.grey, size: 18);
    case SyncStatus.ERROR:
      return Icon(Icons.error,
          color: colored ? Colors.red : Colors.grey, size: 18);
    default:
      return const Icon(Icons.all_inclusive, size: 18);
  }
}