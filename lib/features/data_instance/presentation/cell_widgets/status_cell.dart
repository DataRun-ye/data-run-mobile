import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:flutter/material.dart';

class StatusCell extends StatelessWidget {
  const StatusCell({required this.id, this.onTap});

  final String id;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext c) => Center(
      child: GestureDetector(
          onTap: onTap,
          child: SyncStatusBadgesView(
            submissionId: id,
            showCount: false,
          )));
}
