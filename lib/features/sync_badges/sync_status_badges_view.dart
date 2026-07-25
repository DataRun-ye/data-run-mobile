import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/submission_sync_status_model.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/status_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef _SyncBadgeScope = ({
  String? formId,
  String? assignmentId,
  String? submissionId,
});

final _syncStatusBadgesProvider = StreamProvider.autoDispose
    .family<List<SubmissionSyncStatusModel>, _SyncBadgeScope>((ref, scope) {
  return appLocator<AppDatabase>()
      .dataInstancesDao
      .selectStatusByLevel(
        formId: scope.formId,
        assignmentId: scope.assignmentId,
        submissionId: scope.submissionId,
      )
      .watch();
});

class SyncStatusBadgesView extends ConsumerWidget {
  const SyncStatusBadgesView({
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
  Widget build(BuildContext context, WidgetRef ref) {
    final badges = ref.watch(_syncStatusBadgesProvider((
      formId: formId,
      assignmentId: assignmentId,
      submissionId: submissionId,
    )));

    return badges.when(
      loading: () => const SizedBox.square(
        key: ValueKey('sync-status-badges-loading'),
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (items) => Wrap(
        spacing: 2,
        runSpacing: 2,
        children: items
            .where((item) => item.count > 0)
            .map((item) => _SyncStatusBadge(
                  submissionId: submissionId,
                  syncStatus: item.syncState,
                  count: item.count,
                  showCount: showCount,
                ))
            .toList(),
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
