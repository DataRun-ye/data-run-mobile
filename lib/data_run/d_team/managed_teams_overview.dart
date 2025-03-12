// import 'package:datarunmobile/data_run/d_assignment/detail_page.dart';
// import 'package:datarunmobile/data_run/d_team/team_details_page.dart';
// import 'package:flutter/material.dart';
//
// class ManageTeamsOverview extends StatelessWidget {
//   const ManageTeamsOverview({required this.teams, super.key});
//
//   final List<TeamSummary> teams;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(8.0),
//       itemCount: teams.length,
//       itemBuilder: (context, index) {
//         final team = teams[index];
//         return _buildTeamCard(context, team);
//       },
//     );
//   }
//
//   Widget _buildTeamCard(BuildContext context, TeamSummary team) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   team.name,
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 Text(
//                   '${team.membersCount} Members',
//                   style: Theme.of(context).textTheme.labelMedium,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Assignments Summary
//             _buildSummaryRow('Assignments', team.assignmentsSummary),
//             const SizedBox(height: 8),
//
//             // Resources Summary
//             _buildResourceSummaryRow('Resources', team.resourcesSummary),
//
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _onViewDetails(context, team),
//                   child: const Text('View Details'),
//                 ),
//                 TextButton(
//                   onPressed: () => _onManageTeam(context, team),
//                   child: const Text('Manage Team'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSummaryRow(String label, Summary summary) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$label Summary',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 4),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildStat('Total', summary.total, Colors.blue),
//             _buildStat('Completed', summary.completed, Colors.green),
//             _buildStat('Remaining', summary.pending, Colors.orange),
//             _buildStat('Overdue', summary.overdue, Colors.red),
//           ],
//         ),
//         const SizedBox(height: 8),
//         LinearProgressIndicator(
//           value: summary.completed / (summary.total == 0 ? 1 : summary.total),
//           backgroundColor: Colors.grey[300],
//           color: Colors.green,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildResourceSummaryRow(String label, ResourceSummary summary) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$label Summary',
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 4),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildStat('Allocated', summary.allocated, Colors.blue),
//             _buildStat('Reached', summary.reachedBeneficiaries, Colors.blueGrey),
//             _buildStat('Used', summary.used, Colors.green),
//           ],
//         ),
//         const SizedBox(height: 8),
//         LinearProgressIndicator(
//           value:
//               summary.used / (summary.allocated == 0 ? 1 : summary.allocated),
//           backgroundColor: Colors.grey[300],
//           color: Colors.green,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStat(String label, int value, Color color) {
//     return Column(
//       children: [
//         Text(
//           value.toString(),
//           style: TextStyle(
//               fontSize: 18, fontWeight: FontWeight.bold, color: color),
//         ),
//         Text(label, style: const TextStyle(color: Colors.grey)),
//       ],
//     );
//   }
//
//   void _onViewDetails(BuildContext context, TeamSummary team) {
//     // Navigate to detailed team view
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => TeamDetailsPage(teamSummary: team)),
//     );
//   }
//
//   void _onManageTeam(BuildContext context, TeamSummary team) {
//     // Open team management page
//   }
// }
//
// class TeamSummary {
//   final String name;
//   final int membersCount;
//   final Summary assignmentsSummary;
//   final ResourceSummary resourcesSummary;
//
//   TeamSummary({
//     required this.name,
//     required this.membersCount,
//     required this.assignmentsSummary,
//     required this.resourcesSummary,
//   });
// }
//
// class Summary {
//   final int total;
//   final int completed;
//   final int pending;
//   final int overdue;
//
//   Summary({
//     required this.total,
//     required this.completed,
//     required this.pending,
//     required this.overdue,
//   });
// }
//
// class ResourceSummary {
//   final int allocated;
//   final int used;
//   final int beneficiearies;
//   final int reachedBeneficiaries;
//
//   ResourceSummary({
//     required this.allocated,
//     required this.used,
//     required this.beneficiearies,
//     required this.reachedBeneficiaries,
//   });
// }
