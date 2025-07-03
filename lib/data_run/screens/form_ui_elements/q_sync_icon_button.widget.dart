import 'package:d_sdk/database/shared/shared.dart';
import 'package:flutter/material.dart';

class QSyncIconButton extends StatelessWidget {
  const QSyncIconButton({
    super.key,
    required this.state,
    this.onUnsyncedPressed,
    this.onErrorPressed,
  });

  final InstanceSyncStatus? state;
  final VoidCallback? onUnsyncedPressed;
  final VoidCallback? onErrorPressed;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case InstanceSyncStatus.synced:
        return const IconButton(
          icon: Icon(Icons.check, color: Colors.white60),
          onPressed: null,
        );
      case InstanceSyncStatus.draft:
        return const IconButton(
          icon: Icon(Icons.check, color: Colors.white60),
          onPressed: null,
        );
      case InstanceSyncStatus.finalized:
        return IconButton(
          enableFeedback: true,
          icon: const Icon(Icons.sync, color: Colors.black45, size: 35),
          onPressed: onUnsyncedPressed,
        );
      case InstanceSyncStatus.syncFailed:
        return IconButton(
          icon: const Icon(Icons.error, color: Colors.red),
          onPressed: onErrorPressed,
        );
      default:
        return const Icon(Icons.all_inclusive);
    }
  }
}
