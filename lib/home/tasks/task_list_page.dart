// import 'package:flutter/material.dart';
//
// import 'dynamic_form.dart';
//
// class TaskDetailPage extends StatefulWidget {
//   final String location;
//   final String taskId;
//   final int expectedTarget;
//   final List<SubmissionVisit> visits;
//
//   const TaskDetailPage({
//     Key? key,
//     required this.location,
//     required this.taskId,
//     required this.expectedTarget,
//     required this.visits,
//   }) : super(key: key);
//
//   @override
//   _TaskDetailPageState createState() => _TaskDetailPageState();
// }
//
// class _TaskDetailPageState extends State<TaskDetailPage> {
//   bool _expanded = false;
//   int _currentVisitIndex = 0;
//   late Map<String, dynamic> _formValues;
//
//   @override
//   void initState() {
//     super.initState();
//     _formValues = {};
// // If there's a draft, load its index
//     final draftIndex = widget.visits.indexWhere((v) => v.isDraft);
//     _currentVisitIndex = draftIndex != -1 ? draftIndex : widget.visits.length;
//   }
//
//   void _startNewVisit() {
//     setState(() {
//       _currentVisitIndex = widget.visits.length;
//       _formValues.clear();
//     });
//   }
//
//   void _onSubmit(Map<String, dynamic> values) {
// // handle save or submit
//     print('Submitting visit #${_currentVisitIndex + 1}: ');
//     print(values);
// // update visits list, progress, etc.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final completed = widget.visits
//         .where((v) => v.isSubmitted)
//         .fold<int>(0, (sum, v) => sum + v.progress);
//     final visitLabel =
//         'Visit ${_currentVisitIndex + 1} of ${widget.visits.length + 1}';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location: ${widget.location} (Task #${widget.taskId})'),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(24),
//           child: Padding(
//             padding: EdgeInsets.only(bottom: 8),
//             child: Text(visitLabel, style: TextStyle(color: Colors.white70)),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           _buildInfoBar(completed),
//           buildPreviousVisits(),
//           Expanded(
//             child: DynamicForm(
//               schemaJson: formSchemaJson,
//               initialValues: widget.visits.length > _currentVisitIndex
//                   ? widget.visits[_currentVisitIndex].data
//                   : {},
//               readOnly: false,
//               onSubmit: _onSubmit,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           if (_currentVisitIndex == widget.visits.length)
//             FloatingActionButton.extended(
//               icon: Icon(Icons.add),
//               label: Text('New Visit'),
//               onPressed: _startNewVisit,
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoBar(int completed) {
//     return Container(
//       color: Colors.grey.shade200,
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Date: ${DateTime.now().toLocal().toString().split(' ')[0]}'),
//           Text('Team: Alpha'),
//           Text('Progress: $completed/${widget.expectedTarget}'),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPreviousVisits() {
//     if (widget.visits.isEmpty) return SizedBox.shrink();
//     return ExpansionPanelList(
//       expansionCallback: (_, __) => setState(() => _expanded = !_expanded),
//       children: [
//         ExpansionPanel(
//           headerBuilder: (_, __) => ListTile(
//             title: Text('Previous Submissions'),
//           ),
//           isExpanded: _expanded,
//           body: Column(
//             children: widget.visits.map((visit) {
//               final idx = widget.visits.indexOf(visit);
//               return ListTile(
//                 leading: Icon(visit.isDraft ? Icons.edit : Icons.check),
//                 title: Text(
//                     'Visit ${idx + 1}: ${visit.date.toLocal().toString().split(' ')[0]}'),
//                 subtitle: Text(visit.isDraft
//                     ? 'Draft'
//                     : 'Submitted (${visit.progress}/${widget.expectedTarget})'),
//                 trailing: TextButton(
//                   child: Text(visit.isDraft ? 'Resume' : 'View'),
//                   onPressed: () {
//                     setState(() {
//                       _currentVisitIndex = idx;
//                     });
//                   },
//                 ),
//               );
//             }).toList(),
//           ),
//         )
//       ],
//     );
//   }
// }
//
// // Dummy model
// class SubmissionVisit {
//   final DateTime date;
//   final bool isDraft;
//   final bool isSubmitted;
//   final int progress;
//   final Map<String, dynamic> data;
//
//   SubmissionVisit({
//     required this.date,
//     required this.isDraft,
//     required this.isSubmitted,
//     required this.progress,
//     required this.data,
//   });
// }
