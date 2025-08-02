import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:datarunmobile/features/form/presentation/sync_status_icon.dart';
import 'package:flutter/material.dart';

class StatusCell extends StatelessWidget {
  const StatusCell({required this.syncState, this.onTap});

  final InstanceSyncStatus syncState;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext c) =>
      Center(child: GestureDetector(onTap: onTap, child: buildStatusIcon(syncState)));
}
