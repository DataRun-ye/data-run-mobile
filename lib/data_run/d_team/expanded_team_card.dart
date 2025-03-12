// import 'package:d2_remote/modules/metadatarun/teams/entities/d_team.entity.dart';
// import 'package:datarunmobile/data_run/d_team/expanded_team_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TeamCard extends ConsumerWidget {
//   final Team team;

//   const TeamCard({super.key, required this.team});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final expandedTeams = ref.watch(expandedTeamProvider);
//     final isExpanded = expandedTeams.contains(team.id);

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: ExpansionTile(
//         key: PageStorageKey(team.id), // Ensures proper state retention.
//         title: Text(
//           team.name ?? '',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         subtitle: Text(
//           'Assignments: ${team.assignmentsTotal}, Completed: ${team.completedAssignments}',
//         ),
//         initiallyExpanded: isExpanded,
//         onExpansionChanged: (expanded) {
//           ref.read(expandedTeamProvider.notifier).toggle(team.id);
//         },
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
