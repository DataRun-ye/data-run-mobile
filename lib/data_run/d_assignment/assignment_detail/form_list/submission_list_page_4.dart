// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// enum SyncStatus { submitted, finalReady, draft }
//
// class DataElementValue {
//   final String label;
//   final String value;
//   final bool shown;
//
//   DataElementValue({
//     required this.label,
//     required this.value,
//     this.shown = false,
//   });
// }
//
// class Submission {
//   final String formName;
//   final String version;
//   final String orgUnit;
//   final String progressStatus;
//   final DateTime submittedAt;
//   final String syncStatus;
//   final List<DataElementValue> dataValues;
//
//   Submission({
//     required this.formName,
//     required this.version,
//     required this.orgUnit,
//     required this.progressStatus,
//     required this.submittedAt,
//     required this.syncStatus,
//     required this.dataValues,
//   });
// }
//
// class SubmissionListPage4 extends StatelessWidget {
//   const SubmissionListPage4({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final fakeSubmissions = [
//       Submission(
//         formName: 'Health Survey',
//         version: 'v2.1',
//         orgUnit: 'Kampala District',
//         progressStatus: 'Completed',
//         submittedAt: DateTime.now().subtract(const Duration(hours: 2)),
//         syncStatus: 'Final',
//         dataValues: [
//           DataElementValue(label: 'Age', value: '34', shown: true),
//           DataElementValue(label: 'Gender', value: 'Male', shown: true),
//           DataElementValue(label: 'Temperature', value: '37.2°C', shown: true),
//           DataElementValue(label: 'Blood Pressure', value: '120/80', shown: true),
//           DataElementValue(label: 'Heart Rate', value: '72 bpm', shown: true),
//         ],
//       ),
//       Submission(
//         formName: 'Education Survey',
//         version: 'v1.5',
//         orgUnit: 'Jinja Region',
//         progressStatus: 'In Progress',
//         submittedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
//         syncStatus: 'Draft',
//         dataValues: [
//           DataElementValue(label: 'School', value: "St. Mary's High", shown: true),
//           DataElementValue(label: 'Students', value: '560', shown: true),
//           DataElementValue(label: 'Pass Rate', value: '85%', shown: true),
//           DataElementValue(label: 'New Enrollments', value: '120', shown: true),
//         ],
//       ),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Submissions')),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: fakeSubmissions.length,
//         itemBuilder: (context, index) {
//           final submission = fakeSubmissions[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Slidable(
//               key: ValueKey('${submission.formName}-${submission.submittedAt}'),
//               startActionPane: ActionPane(
//                 motion: const DrawerMotion(),
//                 extentRatio: 0.5,
//                 children: [
//                   SlidableAction(
//                     onPressed: (_) => onMarkFinal(context, submission),
//                     icon: Icons.check_circle,
//                     label: 'Mark Final',
//                     backgroundColor: Colors.indigo,
//                   ),
//                   SlidableAction(
//                     onPressed: (_) => onSubmit(context, submission),
//                     icon: Icons.cloud_upload,
//                     label: 'Submit',
//                     backgroundColor: Colors.teal,
//                   ),
//                 ],
//               ),
//               endActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 extentRatio: 0.25,
//                 children: [
//                   SlidableAction(
//                     onPressed: (_) => onDelete(context, submission),
//                     icon: Icons.delete,
//                     label: 'Delete',
//                     backgroundColor: Colors.red.shade400,
//                   ),
//                 ],
//               ),
//               child: SubmissionCard(submission: submission),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void onMarkFinal(BuildContext context, Submission submission) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Marked "${submission.formName}" as Final')),
//     );
//   }
//
//   void onSubmit(BuildContext context, Submission submission) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Submitted "${submission.formName}"')),
//     );
//   }
//
//   void onDelete(BuildContext context, Submission submission) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Deleted "${submission.formName}"')),
//     );
//   }
// }
//
// class SubmissionCard extends StatefulWidget {
//   final Submission submission;
//   const SubmissionCard({super.key, required this.submission});
//
//   @override
//   State<SubmissionCard> createState() => _SubmissionCardState();
// }
//
// class _SubmissionCardState extends State<SubmissionCard> {
//   bool _expanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final submission = widget.submission;
//     final theme = Theme.of(context);
//     final metadataStyle = theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700);
//     final shownFields = submission.dataValues.where((e) => e.shown).toList();
//
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(submission.formName, style: theme.textTheme.titleMedium),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text('v${submission.version}', style: metadataStyle),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             // Metadata chips
//             Wrap(
//               spacing: 16,
//               runSpacing: 8,
//               children: [
//                 _metadataChip(Icons.location_on, submission.orgUnit),
//                 _metadataChip(Icons.timeline, submission.progressStatus),
//                 _metadataChip(Icons.access_time,
//                     '${submission.submittedAt.hour.toString().padLeft(2, '0')}:${submission.submittedAt.minute.toString().padLeft(2, '0')}' ),
//                 _metadataChip(Icons.sync, submission.syncStatus,
//                     bgColor: _statusColor(submission.syncStatus)),
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Show limited chips or full table
//             if (!_expanded)
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 8,
//                 children: shownFields.take(3).map((e) => _dataElementChip(e.label, e.value)).toList(),
//               )
//             else
//               Table(
//                 border: TableBorder.all(color: Colors.grey.shade300),
//                 columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
//                 children: [
//                   for (int i = 0; i < shownFields.length; i += 2)
//                     TableRow(children: [
//                       _tableCell(shownFields[i]),
//                       if (i + 1 < shownFields.length) _tableCell(shownFields[i + 1]) else const SizedBox.shrink(),
//                     ]),
//                 ],
//               ),
//
//             if (shownFields.length > 3)
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: TextButton(
//                   onPressed: () => setState(() => _expanded = !_expanded),
//                   child: Text(_expanded ? 'Show less' : 'Show more'),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _metadataChip(IconData icon, String label, {Color? bgColor}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: bgColor ?? Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [Icon(icon, size: 14, color: Colors.grey.shade700), const SizedBox(width: 6), Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey))],
//       ),
//     );
//   }
//
//   Widget _dataElementChip(String key, String value) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.deepPurple.shade50,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text('$key: $value', style: const TextStyle(fontSize: 13, color: Colors.black87)),
//     );
//   }
//
//   Widget _tableCell(DataElementValue field) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Text('${field.label}: ${field.value}', style: const TextStyle(fontSize: 13)),
//     );
//   }
//
//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'submitted':
//         return Colors.green.shade100;
//       case 'final':
//         return Colors.orange.shade100;
//       case 'draft':
//         return Colors.grey.shade300;
//       default:
//         return Colors.grey.shade200;
//     }
//   }
// }
