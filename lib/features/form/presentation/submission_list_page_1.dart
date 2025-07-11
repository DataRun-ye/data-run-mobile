// Fake Models

import 'package:flutter/material.dart';

enum SyncStatus { submitted, finalReady, draft }

class DataElementValue {
  DataElementValue({
    required this.label,
    required this.value,
    this.shown = false,
  });
  final String label;
  final String value;
  final bool shown;
}

class Submission {
  Submission({
    required this.formName,
    required this.version,
    required this.orgUnit,
    required this.progress,
    required this.submittedAt,
    required this.syncStatus,
    required this.dataValues,
  });
  final String formName;
  final String version;
  final String orgUnit;
  final String progress;
  final DateTime submittedAt;
  final SyncStatus syncStatus;
  final List<DataElementValue> dataValues;
}

// UI

class SubmissionListPage1 extends StatelessWidget {
  const SubmissionListPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final submissions = [
      Submission(
        formName: 'Household Survey',
        version: 'v1.2',
        orgUnit: 'Central District',
        progress: 'Completed',
        submittedAt: DateTime(2025, 5, 19, 10, 30),
        syncStatus: SyncStatus.submitted,
        dataValues: [
          DataElementValue(label: 'Name', value: 'John Doe', shown: true),
          DataElementValue(label: 'Age', value: '32', shown: true),
          DataElementValue(
              label: 'Visit Date', value: '18 May 2025', shown: true),
          DataElementValue(label: 'Household Size', value: '5', shown: false),
        ],
      ),
      Submission(
        formName: 'Malaria Check',
        version: 'v3.0',
        orgUnit: 'East Zone',
        progress: 'In Progress',
        submittedAt: DateTime(2025, 5, 20, 14, 10),
        syncStatus: SyncStatus.draft,
        dataValues: [
          DataElementValue(label: 'Patient', value: 'Alice K.', shown: true),
          DataElementValue(label: 'Temperature', value: '38.5°C', shown: true),
          DataElementValue(
              label: 'Test Result', value: 'Pending', shown: false),
        ],
      ),
    ];

    return ListView.builder(
      itemCount: submissions.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SubmissionCard(submission: submissions[index]),
      ),
    );
  }
}

class SubmissionCard extends StatelessWidget {
  const SubmissionCard({super.key, required this.submission});
  final Submission submission;

  IconData getSyncIcon(SyncStatus status) {
    switch (status) {
      case SyncStatus.submitted:
        return Icons.cloud_done;
      case SyncStatus.finalReady:
        return Icons.cloud_upload;
      case SyncStatus.draft:
        return Icons.edit_note;
    }
  }

  Color getSyncColor(SyncStatus status) {
    switch (status) {
      case SyncStatus.submitted:
        return Colors.green.shade600;
      case SyncStatus.finalReady:
        return Colors.orange.shade700;
      case SyncStatus.draft:
        return Colors.grey.shade600;
    }
  }

  String getSyncLabel(SyncStatus status) {
    switch (status) {
      case SyncStatus.submitted:
        return 'Submitted';
      case SyncStatus.finalReady:
        return 'Final';
      case SyncStatus.draft:
        return 'Draft';
    }
  }

  @override
  Widget build(BuildContext context) {
    final shownFields = submission.dataValues.where((e) => e.shown).toList();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form name and version
            Text(
              submission.formName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'Version: ${submission.version}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 8),

            // OrgUnit & progress
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  submission.orgUnit,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.check_circle_outline, size: 16),
                const SizedBox(width: 4),
                Text(
                  submission.progress,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Shown data fields (horizontal wrap)
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: shownFields.map((field) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${field.label}: ',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(field.value),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Submitted date & sync status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "${submission.submittedAt.day} ${_monthName(submission.submittedAt.month)} ${submission.submittedAt.year} • ${submission.submittedAt.hour.toString().padLeft(2, '0')}:${submission.submittedAt.minute.toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(getSyncIcon(submission.syncStatus),
                        size: 16, color: getSyncColor(submission.syncStatus)),
                    const SizedBox(width: 4),
                    Text(
                      getSyncLabel(submission.syncStatus),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: getSyncColor(submission.syncStatus),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
