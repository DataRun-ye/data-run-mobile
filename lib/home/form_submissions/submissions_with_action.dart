// import 'package:datarunmobile/home/form_submissions/main_submissions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
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
// class SubmissionListPage extends StatelessWidget {
//   const SubmissionListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Submissions')),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: submissions.length,
//         itemBuilder: (context, index) {
//           final submission = submissions[index];
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
