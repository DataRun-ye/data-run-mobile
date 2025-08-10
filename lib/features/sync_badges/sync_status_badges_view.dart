import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/status_icon.dart';
import 'package:datarunmobile/features/sync_badges/sync_badges_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

String ValueOrEmpty(String? value) => value ?? '';

class SyncStatusBadgesView extends StatelessWidget {
  SyncStatusBadgesView({
    super.key,
    this.formId,
    this.assignmentId,
    this.submissionId,
    this.showCount = true,
  });

  final String? formId;
  final String? assignmentId;
  final String? submissionId;
  final bool showCount;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SyncBadgesViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(
              heightFactor: 3,
              widthFactor: 3,
              child: CircularProgressIndicator(),
            )
          : Wrap(
              spacing: 2,
              runSpacing: 2,
              // alignment: WrapAlignment.end,
              children: model.data
                      ?.where((e) => e.count > 0)
                      .map<Widget>((e) => _SyncStatusBadge(
                            submissionId: submissionId,
                            syncStatus: e.syncState,
                            count: e.count,
                            showCount: showCount,
                          ))
                      .toList() ??
                  [],
            ),
      viewModelBuilder: () => SyncBadgesViewModel(
        formId: formId,
        assignmentId: assignmentId,
        submissionId: submissionId,
      ),
    );
  }
}

class _SyncStatusBadge extends StatelessWidget {
  const _SyncStatusBadge({
    required this.syncStatus,
    required this.count,
    this.submissionId,
    this.showCount = true,
  });

  final String? submissionId;
  final InstanceSyncStatus syncStatus;
  final bool showCount;
  final int count;

  @override
  Widget build(BuildContext context) {
    final child = showCount
        ? Column(children: [
            StatusIcon(
                key: ValueKey('${submissionId}_${syncStatus.name}'),
                syncState: syncStatus),
            const SizedBox(width: 4),
            Text('$count', style: Theme.of(context).textTheme.bodyMedium)
          ])
        : StatusIcon(syncState: syncStatus);
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 2.0), child: child);
  }
}
