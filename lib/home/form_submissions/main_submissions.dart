// import 'package:d_sdk/database/shared/submission_status.dart';
// import 'package:d_sdk/database/shared/data_element_value.dart';
// import 'package:d_sdk/database/shared/submission_card_summary.dart';
// import 'package:datarunmobile/home/form_submissions/submissions_with_action.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Submission List Demo',
//       theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
//       home: const SubmissionListPage(),
//     );
//   }
// }
//
// // Fake Models
//
// enum SyncStatus { submitted, finalReady, draft }
//
// // UI
//
// class SubmissionListPage extends StatelessWidget {
//   const SubmissionListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: submissions.length,
//       padding: const EdgeInsets.all(12),
//       itemBuilder: (_, index) => Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: SubmissionCard(submission: submissions[index]),
//       ),
//     );
//   }
// }
//
// class SubmissionCard extends StatelessWidget {
//   final SubmissionCardSummary submission;
//
//   const SubmissionCard({super.key, required this.submission});
//
//   IconData getSyncIcon(SyncStatus status) {
//     switch (status) {
//       case SyncStatus.submitted:
//         return Icons.cloud_done;
//       case SyncStatus.finalReady:
//         return Icons.cloud_upload;
//       case SyncStatus.draft:
//         return Icons.edit_note;
//     }
//   }
//
//   Color getSyncColor(SyncStatus status) {
//     switch (status) {
//       case SyncStatus.submitted:
//         return Colors.green.shade600;
//       case SyncStatus.finalReady:
//         return Colors.orange.shade700;
//       case SyncStatus.draft:
//         return Colors.grey.shade600;
//     }
//   }
//
//   String getSyncLabel(SubmissionStatus status) {
//     switch (status) {
//       case SubmissionStatus.submitted:
//         return 'Submitted';
//       case SyncStatus.finalReady:
//         return 'Final (Ready)';
//       case SyncStatus.draft:
//         return 'Draft';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final shownFields = submission.dataValues.where((e) => e.shown).toList();
//
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Form name and version
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   submission.formName,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   submission.version,
//                   style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             // OrgUnit & progress
//             Row(
//               children: [
//                 const Icon(Icons.location_on_outlined, size: 16),
//                 const SizedBox(width: 4),
//                 Text(
//                   submission.orgUnitName,
//                   style: const TextStyle(fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(width: 16),
//                 const Icon(Icons.check_circle_outline, size: 16),
//                 const SizedBox(width: 4),
//                 Text(
//                   submission.progress.name,
//                   style: TextStyle(color: Colors.grey[700]),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             // Shown data fields (horizontal wrap)
//             Wrap(
//               spacing: 16,
//               runSpacing: 8,
//               children: shownFields.map((field) {
//                 return Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       '${field.label}: ',
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                     Text(field.value),
//                   ],
//                 );
//               }).toList(),
//             ),
//
//             const SizedBox(height: 12),
//
//             // Submitted date & sync status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.access_time, size: 16),
//                     const SizedBox(width: 4),
//                     Text(
//                       "${submission.submittedAt.day} ${_monthName(submission.submittedAt.month)} ${submission.submittedAt.year} • ${submission.submittedAt.hour.toString().padLeft(2, '0')}:${submission.submittedAt.minute.toString().padLeft(2, '0')}",
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Icon(getSyncIcon(submission.syncStatus),
//                         size: 16, color: getSyncColor(submission.syncStatus)),
//                     const SizedBox(width: 4),
//                     Text(
//                       getSyncLabel(submission.syncStatus),
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: getSyncColor(submission.syncStatus),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _monthName(int month) {
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return months[month - 1];
//   }
// }
//
// final submissions = [
//   SubmissionCardSummary(
//     formName: 'LSM Form',
//     version: 'v1.2',
//     orgUnitName: 'Village name',
//     progress: 'Completed',
//     submittedAt: DateTime(2025, 5, 19, 10, 30),
//     syncStatus: SubmissionStatus.synced,
//     dataValues: [
//       DataElementValue(label: 'Name', value: 'Owned by name', shown: true),
//       DataElementValue(label: 'Age', value: '32', shown: true),
//       DataElementValue(label: 'Visit Date', value: '18 May 2025', shown: true),
//       DataElementValue(label: 'Sources', value: '5', shown: false),
//     ],
//   ),
//   Submission(
//     formName: 'LSM Form',
//     version: 'v1.5',
//     orgUnit: 'Al Hodaydah',
//     progress: 'In Progress',
//     submittedAt: DateTime.now().subtract(const Duration(hours: 5)),
//     syncStatus: SyncStatus.finalReady,
//     dataValues: [
//       DataElementValue(label: 'Name', value: 'Ahmed A.', shown: true),
//       DataElementValue(label: 'Age', value: '32', shown: true),
//       DataElementValue(label: 'Visit Date', value: '18 May 2025', shown: true),
//       DataElementValue(label: 'Sources', value: '5', shown: false),
//     ],
//   ),
//   Submission(
//     formName: 'Fast Response Form',
//     version: 'v3.0',
//     orgUnit: 'Amran',
//     progress: 'In Progress',
//     submittedAt: DateTime(2025, 5, 20, 14, 10),
//     syncStatus: SyncStatus.draft,
//     dataValues: [
//       DataElementValue(label: 'Patient', value: 'Ahmed A.', shown: true),
//       DataElementValue(label: 'Severity', value: 'Simple', shown: true),
//       DataElementValue(label: 'Test Result', value: 'PF', shown: false),
//     ],
//   ),
// ];
