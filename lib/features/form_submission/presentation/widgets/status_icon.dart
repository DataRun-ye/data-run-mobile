import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:flutter/material.dart';

class StatusIcon extends StatefulWidget {
  const StatusIcon({super.key, required this.syncState});

  /// Accepts either InstanceSyncStatus or String (e.g. 'uploading')
  final InstanceSyncStatus? syncState;

  @override
  State<StatusIcon> createState() => _StatusIconState();
}

class _StatusIconState extends State<StatusIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  InstanceSyncStatus? _lastParsed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _maybeStartOrStop();
  }

  @override
  void didUpdateWidget(covariant StatusIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeStartOrStop();
  }

  void _maybeStartOrStop() {
    final parsed = widget.syncState;

    if (parsed == InstanceSyncStatus.uploading) {
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    } else {
      if (_controller.isAnimating) {
        _controller.stop();
        _controller.reset();
      }
    }
    _lastParsed = parsed;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final parsed = widget.syncState;
    final tooltip = parsed?.name.toLowerCase() ?? '-';

    return Tooltip(
      message: tooltip,
      child: Builder(builder: (_) {
        switch (parsed) {
          case InstanceSyncStatus.synced:
            return Icon(Icons.cloud_done, color: Colors.green, size: 20);
          // return Icon(Icons.sync, color:  cs.primaryContainer, size: 20);
          case InstanceSyncStatus.finalized:
            return const Icon(Icons.cloud_upload, color: Colors.grey, size: 20);
          case InstanceSyncStatus.draft:
            return Icon(Icons.edit_note, color: Colors.grey[500], size: 20);
          case InstanceSyncStatus.syncFailed:
            return const Icon(Icons.error, color: Colors.red, size: 20);
          case InstanceSyncStatus.uploading:
            return RotationTransition(
              turns: _controller,
              child: Icon(Icons.sync,
                  color: cs.primaryContainer, size: 20),
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
