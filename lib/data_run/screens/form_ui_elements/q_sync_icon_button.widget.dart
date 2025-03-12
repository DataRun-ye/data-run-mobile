import 'package:flutter/material.dart';
import 'package:datarunmobile/core/common/state.dart';

class QSyncIconButton extends StatelessWidget {
  const QSyncIconButton({
    super.key,
    required this.state,
    this.onUnsyncedPressed,
    this.onErrorPressed,
  });
  final SyncStatus? state;
  final VoidCallback? onUnsyncedPressed;
  final VoidCallback? onErrorPressed;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case SyncStatus.SYNCED:
        return const IconButton(
          icon: Icon(Icons.check, color: Colors.white60),
          onPressed: null,
        );
      case SyncStatus.TO_UPDATE:
        return const IconButton(
          icon: Icon(Icons.check, color: Colors.white60),
          onPressed: null,
        );
      case SyncStatus.TO_POST:
        return IconButton(
          enableFeedback: true,
          icon: const Icon(Icons.sync, color: Colors.black45, size: 35),
          onPressed: onUnsyncedPressed,
        );
      case SyncStatus.ERROR:
        return IconButton(
          icon: const Icon(Icons.error, color: Colors.red),
          onPressed: onErrorPressed,
        );
      default:
        return const Icon(Icons.all_inclusive);
    }
  }
}
