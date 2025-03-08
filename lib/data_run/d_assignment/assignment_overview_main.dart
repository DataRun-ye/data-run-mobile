// import 'package:flutter/material.dart';
//
// import 'assignment_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Assignment Overview',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const AssignmentOverviewScreen(),
//     );
//   }
// }
//
// class AssignmentOverviewScreen extends StatefulWidget {
//   const AssignmentOverviewScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AssignmentOverviewScreen> createState() =>
//       _AssignmentOverviewScreenState();
// }
//
// class _AssignmentOverviewScreenState extends State<AssignmentOverviewScreen> {
//   // Sample data for assignments
//   final List<Map<String, dynamic>> assignments = [
//     {
//       'assignmentId': 'A001',
//       'activity': 'Distribute ITNs',
//       'entityCode': 'V001',
//       'entityName': 'Village One',
//       'teamName': 'Team Alpha',
//       'scope': 'Assigned',
//       'status': 'NOT_STARTED',
//       'dueDate': DateTime.now().add(const Duration(days: 2)),
//       'forms': ['Form 1', 'Form 2'],
//     },
//     {
//       'assignmentId': 'A002',
//       'activity': 'Survey Population',
//       'entityCode': 'V002',
//       'entityName': 'Village Two',
//       'teamName': 'Team Beta',
//       'scope': 'Managed',
//       'status': 'IN_PROGRESS',
//       'dueDate': DateTime.now().subtract(const Duration(days: 1)),
//       'forms': ['Form 3', 'Form 4'],
//     },
//   ];
//
//   // Function to handle form submission
//   // void _submitForm(String assignmentId) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text('Submitting form for assignment: $assignmentId')),
//   //   );
//   // }
//
//   // Function to handle status change
//   // void _changeStatus(String assignmentId, String newStatus) {
//   //   setState(() {
//   //     final assignment =
//   //     assignments.firstWhere((a) => a['assignmentId'] == assignmentId);
//   //     assignment['status'] = newStatus;
//   //   });
//   //
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text('Status updated to $newStatus for $assignmentId')),
//   //   );
//   // }
//
//   // Function to view details
//   // void _viewDetails(String assignmentId) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (_) => AlertDialog(
//   //       title: const Text('Assignment Details'),
//   //       content: Text('Details for assignment: $assignmentId'),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context),
//   //           child: const Text('Close'),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Assignment Overview')),
//       body: AssignmentPage(),
//       // body: ListView.builder(
//       //   itemCount: assignments.length,
//       //   itemBuilder: (context, index) {
//       //     final assignment = assignments[index];
//       //     return AssignmentOverviewItem(
//       //       assignmentId: assignment['assignmentId'],
//       //       activity: assignment['activity'],
//       //       entityCode: assignment['entityCode'],
//       //       entityName: assignment['entityName'],
//       //       teamName: assignment['teamName'],
//       //       scope: assignment['scope'],
//       //       status: assignment['status'],
//       //       dueDate: assignment['dueDate'],
//       //       forms: assignment['forms'],
//       //       onSubmitForm: () => _submitForm(assignment['assignmentId']),
//       //       onViewDetails: () => _viewDetails(assignment['assignmentId']),
//       //       onChangeStatus: (newStatus) =>
//       //           _changeStatus(assignment['assignmentId'], newStatus!),
//       //     );
//       //   },
//       // ),
//     );
//   }
// }
