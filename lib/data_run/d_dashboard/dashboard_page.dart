// import 'package:datarunmobile/data_run/d_assignment/assignment_overview.dart';
// import 'package:datarunmobile/data_run/d_assignment/detail_page.dart';
// import 'package:datarunmobile/data_run/d_assignment/forms_overview.dart';
// import 'package:datarunmobile/data_run/d_team/managed_team_screen.dart';
// import 'package:datarunmobile/data_run/d_team/managed_teams_overview.dart';
// import 'package:datarunmobile/utils/navigator_key.dart';
// import 'package:flutter/material.dart';
//
// class DashboardPage extends StatelessWidget {
//   DashboardPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dashboard')),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Divider(),
//             SizedBox(height: 20),
//             const Text('Your Assignments'),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 // Navigate to the Forms Overview page
//                 Navigator.push(
//                   navigatorKey.currentContext!,
//                   MaterialPageRoute(
//                     builder: (context) => ManageTeamsScreen(),
//                   ),
//                 );
//               },
//               child: AssignmentsOverview(
//                 total: 20,
//                 completed: 10,
//                 pending: 7,
//                 overdue: 3,
//                 onCategoryTap: (category) {
//                   // Navigate to specific details based on the category
//                   Navigator.push(
//                     navigatorKey.currentContext!,
//                     MaterialPageRoute(
//                       builder: (context) => DetailsPage(category: category),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // SizedBox(height: 20),
//             // Divider(),
//             // SizedBox(height: 20),
//             // const Text('Forms'),
//             // FormsOverview(
//             //   available: 10,
//             //   submitted: 7,
//             //   pending: 3,
//             // ),
//             SizedBox(height: 20),
//             Divider(),
//             SizedBox(height: 20),
//             const Text('Managed Teams'),
//             SizedBox(height: 10),
//             SizedBox(
//               height: 300,
//               child: ManageTeamsOverview(
//                 teams: testData,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<TeamSummary> testData = [
//     TeamSummary(
//       name: 'Ali Team',
//       membersCount: 10,
//       assignmentsSummary: Summary(
//         total: 50,
//         completed: 45,
//         pending: 4,
//         overdue: 1,
//       ),
//       resourcesSummary: ResourceSummary(
//         allocated: 3000,
//         used: 2250,
//         beneficiearies: 100,
//         reachedBeneficiaries: 75,
//       ),
//     ),
//     TeamSummary(
//       name: 'Ahmed Team',
//       membersCount: 8,
//       assignmentsSummary: Summary(
//         total: 30,
//         completed: 25,
//         pending: 3,
//         overdue: 2,
//       ),
//       resourcesSummary: ResourceSummary(
//         allocated: 1800,
//         used: 1250,
//         beneficiearies: 3600,
//         reachedBeneficiaries: 2600,
//       ),
//     ),
//     TeamSummary(
//       name: 'Sam Team',
//       membersCount: 15,
//       assignmentsSummary: Summary(
//         total: 70,
//         completed: 60,
//         pending: 7,
//         overdue: 3,
//       ),
//       resourcesSummary: ResourceSummary(
//         allocated: 2800,
//         used: 989,
//         beneficiearies: 5000,
//         reachedBeneficiaries: 4000,
//       ),
//     ),
//     TeamSummary(
//       name: 'Raed Team',
//       membersCount: 12,
//       assignmentsSummary: Summary(
//         total: 40,
//         completed: 35,
//         pending: 4,
//         overdue: 1,
//       ),
//       resourcesSummary: ResourceSummary(
//         allocated: 2500,
//         used: 1000,
//         beneficiearies: 6000,
//         reachedBeneficiaries: 5000,
//       ),
//     ),
//     TeamSummary(
//       name: 'Mu Team',
//       membersCount: 20,
//       assignmentsSummary: Summary(
//         total: 100,
//         completed: 90,
//         pending: 8,
//         overdue: 2,
//       ),
//       resourcesSummary: ResourceSummary(
//         allocated: 2000,
//         used: 500,
//         beneficiearies: 8000,
//         reachedBeneficiaries: 7000,
//       ),
//     ),
//   ];
// }
