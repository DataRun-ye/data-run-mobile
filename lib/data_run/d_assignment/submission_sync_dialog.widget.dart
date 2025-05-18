import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncDialog extends ConsumerStatefulWidget {
  const SyncDialog({
    super.key,
    required this.entityIds,
    required this.syncEntity,
  });

  final List<String> entityIds;
  final Function(List<String>? entityUids) syncEntity;

  @override
  SyncDialogState createState() => SyncDialogState();
}

class SyncDialogState extends ConsumerState<SyncDialog> {
  bool _isSyncing = false;
  bool _isSyncingFinished = false;
  List<String> _syncErrors = <String>[];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      title: Text(S.of(context).syncFormData),
      content: _buildContent(),
      actions: _buildActions(),
    );
  }

  Widget _buildContent() {
    if (!_isSyncing) {
      return Text(S.of(context).confirmSyncFormData);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const LinearProgressIndicator(),
        const SizedBox(height: 16),
        Text('${S.of(context).syncingData} ${widget.entityIds.length}'),
        if (_syncErrors.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              '${S.of(context).error}: ${_syncErrors.join(', ')}',
            ),
          ),
      ],
    );
  }

  List<Widget> _buildActions() {
    if (!_isSyncing) {
      return <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: _startSyncing,
          child: Text(S.of(context).confirm),
        ),
      ];
    }

    if (_isSyncingFinished) {
      return <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).ok),
        ),
      ];
    }

    return <Widget>[];
  }

  Future<void> _startSyncing() async {
    setState(() {
      _isSyncing = true;
      _syncErrors = <String>[];
    });

    try {
      await widget.syncEntity(widget.entityIds);
    } catch (e) {
      _syncErrors.addAll(widget.entityIds);
    }

    setState(() {
      _isSyncingFinished = true;
    });
  }
}
