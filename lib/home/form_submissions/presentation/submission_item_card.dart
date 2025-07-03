import 'package:d_sdk/database/shared/submission_card_summary.dart';
import 'package:d_sdk/database/shared/submission_status.dart';
import 'package:flutter/material.dart';

class SubmissionCard extends StatelessWidget {
  const SubmissionCard({super.key, required this.submission, this.onTap});

  final SubmissionSummary submission;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metadataStyle =
        theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(submission.form.displayLabel,
                    style: theme.textTheme.titleMedium),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('v${submission.versionNumber}',
                      style: metadataStyle),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Metadata Row
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _metadataChip(
                    Icons.location_on, submission.orgUnit.displayLabel),
                if (submission.progress != null)
                  _metadataChip(Icons.timeline, submission.progress!.name),
                _metadataChip(Icons.access_time,
                    '${submission.submittedAt?.hour.toString().padLeft(2, '0') ?? 0}:${submission.submittedAt?.minute.toString().padLeft(2, '0') ?? 0}'),
                _metadataChip(Icons.sync, submission.syncStatus.name,
                    bgColor: getSyncColor(submission.syncStatus)),
              ],
            ),

            const SizedBox(height: 12),

            // // Shown Fields (up to 3)
            // if (submission.dataValues.isNotEmpty)
            //   Wrap(
            //     spacing: 12,
            //     runSpacing: 8,
            //     children: submission.dataValues
            //         .take(3)
            //         .map((e) => _dataElementChip(e.displayLabel, e.value))
            //         .toList(),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _metadataChip(IconData icon, String label, {Color? bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
        ],
      ),
    );
  }

  Widget _dataElementChip(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$key: $value',
          style: const TextStyle(fontSize: 13, color: Colors.black87)),
    );
  }

  // Color _statusColor(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'submitted':
  //       return Colors.green.shade100;
  //     case 'final':
  //       return Colors.orange.shade100;
  //     case 'draft':
  //       return Colors.grey.shade300;
  //     default:
  //       return Colors.grey.shade200;
  //   }
  // }

  Color getSyncColor(InstanceSyncStatus status) {
    switch (status) {
      case InstanceSyncStatus.synced:
        return Colors.green.shade100;
      case InstanceSyncStatus.finalized:
        return Colors.orange.shade100;
      case InstanceSyncStatus.draft:
        return Colors.grey.shade300;
      case InstanceSyncStatus.syncFailed:
        return Colors.red.shade100;
    }
  }

  String getSyncLabel(InstanceSyncStatus status) {
    switch (status) {
      case InstanceSyncStatus.synced:
        return 'Submitted';
      case InstanceSyncStatus.finalized:
        return 'Final (Ready)';
      case InstanceSyncStatus.draft:
        return 'Draft';
      case InstanceSyncStatus.syncFailed:
        return 'Error';
    }
  }
}

// enum SyncStatus { draft, finalized, submitted }
