// import 'package:d_sdk/modules/metadatarun/teams/entities/d_team.entity.dart';
// import 'package:flutter/material.dart';

// class TeamCard extends StatelessWidget {
//   final Team team; // Replace with your team model.

//   const TeamCard({Key? key, required this.team}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: ExpansionTile(
//         title: Text(
//           team.name ?? '',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         subtitle: Text(
//           'Assignments: ${team.assignmentsTotal}, Completed: ${team.completedAssignments}',
//         ),
//         children: [
//           _buildAssignmentBreakdown(),
//           _buildResourceDetails(),
//           _buildActivityFeed(),
//         ],
//       ),
//     );
//   }

//   Widget _buildAssignmentBreakdown() {
//     return ListTile(
//       title: const Text('Assignment Breakdown'),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Critical: ${team.criticalAssignments}'),
//           Text('Normal: ${team.normalAssignments}'),
//         ],
//       ),
//     );
//   }

//   Widget _buildResourceDetails() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns: const [
//           DataColumn(label: Text('Resource')),
//           DataColumn(label: Text('Allocated')),
//           DataColumn(label: Text('Used')),
//         ],
//         rows: team.resources.map((resource) {
//           return DataRow(
//             cells: [
//               DataCell(Text(resource.name)),
//               DataCell(Text(resource.allocated.toString())),
//               DataCell(Text(resource.used.toString())),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildActivityFeed() {
//     return Column(
//       children: team.activities.map((activity) {
//         return ListTile(
//           title: Text(activity.title),
//           subtitle: Text(activity.timestamp),
//         );
//       }).toList(),
//     );
//   }
// }
