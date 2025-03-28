import 'dart:io';

import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/form_submission/submission_count.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_detail/sync_status_icon.dart';
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
}
