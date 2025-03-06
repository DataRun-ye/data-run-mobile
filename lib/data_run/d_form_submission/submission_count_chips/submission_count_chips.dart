import 'dart:io';

import 'package:datarun/commons/custom_widgets/async_value.widget.dart';
import 'package:datarun/core/common/state.dart';
import 'package:datarun/data_run/d_form_submission/submission_count_chips/submission_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CountChip extends ConsumerWidget {
  const CountChip({super.key, required this.syncStatus});

  final SyncStatus syncStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countSync = ref.watch(submissionsSyncStateCountProvider(syncStatus));
    final bool showLabel = !Platform.isWindows;
    return AsyncValueWidget(
      value: countSync,
      valueBuilder: (count) => Tooltip(
        message: Intl.message(syncStatus.name.toLowerCase()),
        child: Chip(
          shadowColor: Theme.of(context).colorScheme.shadow,
          surfaceTintColor: Theme.of(context).colorScheme.primary,
          // avatar: buildStatusIcon(syncStatus, colored: count > 0),
          label: showLabel
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$count',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(width: 4),
                    Text(Intl.message(syncStatus.name.toLowerCase()),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildStatusIcon(syncStatus, colored: count > 0),
                    const SizedBox(width: 16),
                    Text('$count',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
          backgroundColor: Theme.of(context).chipTheme.backgroundColor,
          padding: showLabel
              ? const EdgeInsets.symmetric(horizontal: 8)
              : EdgeInsets.zero,
          visualDensity:
              showLabel ? VisualDensity.standard : VisualDensity.compact,
        ),
      ),
    );
  }

  Widget buildStatusIcon(SyncStatus? status, {bool colored = false}) {
    switch (status) {
      case SyncStatus.SYNCED:
        return Icon(Icons.cloud_done,
            color: colored ? Colors.green : Colors.grey, size: 18);
      case SyncStatus.TO_POST:
        return Icon(Icons.cloud_upload,
            color: colored ? Colors.blue : Colors.grey, size: 18);
      case SyncStatus.TO_UPDATE:
        return Icon(Icons.update,
            color: colored ? Colors.orange : Colors.grey, size: 18);
      case SyncStatus.ERROR:
        return Icon(Icons.error,
            color: colored ? Colors.red : Colors.grey, size: 18);
      default:
        return Icon(Icons.all_inclusive, size: 18);
    }
  }
}
