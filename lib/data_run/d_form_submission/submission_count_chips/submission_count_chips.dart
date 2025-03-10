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
      valueBuilder: (count) => count == 0
          ? const SizedBox.shrink()
          : Tooltip(
              message: Intl.message(syncStatus.name.toLowerCase()),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildStatusIcon(syncStatus, colored: count > 0),
                    const SizedBox(width: 4),
                    Text('$count',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
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
        return Icon(Icons.cloud_off,
            color: colored ? Colors.blue : Colors.grey, size: 18);
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
}
