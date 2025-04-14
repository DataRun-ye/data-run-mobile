import 'package:d_sdk/database/shared/shared.dart';
import 'package:flutter/material.dart';

Widget buildStatusIcon(SubmissionStatus? status) {
  switch (status) {
    case SubmissionStatus.synced:
      return const Icon(Icons.cloud_done, color: Colors.green, size: 18);
    case SubmissionStatus.finalized:
      return const Icon(Icons.cloud_sync, color: Colors.grey, size: 18);
    case SubmissionStatus.draft:
      return Icon(Icons.update, color: Colors.grey[500], size: 18);
    case SubmissionStatus.syncFailed:
      return const Icon(Icons.error, color: Colors.red, size: 18);
    default:
      return const Icon(Icons.all_inclusive, size: 18);
  }
}
