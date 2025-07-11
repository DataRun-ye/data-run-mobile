import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Submission {
  Submission({
    required this.formName,
    required this.version,
    required this.orgUnit,
    required this.progress,
    required this.submittedAt,
    required this.syncStatus,
  });
  final String formName;
  final String version;
  final String orgUnit;
  final String progress;
  final DateTime submittedAt;
  final SyncStatus syncStatus;
}

enum SyncStatus { submitted, finalReady, draft }

final fakeSubmissions = [
  Submission(
    formName: 'Household Survey',
    version: 'v2.1',
    orgUnit: 'Central District',
    progress: 'Completed',
    submittedAt: DateTime.now().subtract(const Duration(days: 1)),
    syncStatus: SyncStatus.submitted,
  ),
  Submission(
    formName: 'Water Point Inspection',
    version: 'v1.5',
    orgUnit: 'Eastern Valley',
    progress: 'In Progress',
    submittedAt: DateTime.now().subtract(const Duration(hours: 5)),
    syncStatus: SyncStatus.finalReady,
  ),
  Submission(
    formName: 'Malaria Follow-up',
    version: 'v3.0',
    orgUnit: 'North Zone',
    progress: 'Not Started',
    submittedAt: DateTime.now().subtract(const Duration(days: 3)),
    syncStatus: SyncStatus.draft,
  ),
];

class SubmissionListScreen2 extends StatelessWidget {
  const SubmissionListScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Submissions')),
      body: ListView.builder(
        itemCount: fakeSubmissions.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return SubmissionCard(submission: fakeSubmissions[index]);
        },
      ),
    );
  }
}

class SubmissionCard extends StatelessWidget {
  const SubmissionCard({super.key, required this.submission});
  final Submission submission;

  Color get syncColor {
    switch (submission.syncStatus) {
      case SyncStatus.submitted:
        return Colors.green;
      case SyncStatus.finalReady:
        return Colors.orange;
      case SyncStatus.draft:
        return Colors.grey;
    }
  }

  IconData get syncIcon {
    switch (submission.syncStatus) {
      case SyncStatus.submitted:
        return Icons.cloud_done;
      case SyncStatus.finalReady:
        return Icons.upload_rounded;
      case SyncStatus.draft:
        return Icons.edit_note;
    }
  }

  String get syncLabel {
    switch (submission.syncStatus) {
      case SyncStatus.submitted:
        return 'Submitted';
      case SyncStatus.finalReady:
        return 'Final (Ready)';
      case SyncStatus.draft:
        return 'Draft';
    }
  }

  @override
  Widget build(BuildContext context) {
    final date =
        DateFormat('dd MMM yyyy • HH:mm').format(submission.submittedAt);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form name & version
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  submission.formName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  submission.version,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Org unit and progress
            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.teal),
                const SizedBox(width: 6),
                Text(
                  submission.orgUnit,
                  style: const TextStyle(fontSize: 15),
                ),
                const Spacer(),
                Chip(
                  label: Text(submission.progress),
                  backgroundColor: Colors.teal[50],
                )
              ],
            ),
            const SizedBox(height: 12),

            // Footer with date and sync status
            Row(
              children: [
                Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(syncIcon, size: 20, color: syncColor),
                    const SizedBox(width: 6),
                    Text(
                      syncLabel,
                      style: TextStyle(
                        color: syncColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
