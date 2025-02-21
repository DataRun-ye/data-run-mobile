// import 'package:flutter/material.dart';
//
// /// A desktop layout with a persistent sidebar and a main content area.
// class DesktopHomeScreen extends StatelessWidget {
//   const DesktopHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           NavigationSidebar(), // The persistent navigation sidebar
//           Expanded(
//             child: AssignmentContentArea(), // Main content area
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// The sidebar for desktop navigation.
// class NavigationSidebar extends StatelessWidget {
//   const NavigationSidebar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 250,
//       color: Colors.grey[200],
//       child: ListView(
//         children: [
//           ListTile(
//             title: Text('Activities'),
//             onTap: () {
//               // Navigate to activities screen
//             },
//           ),
//           ListTile(
//             title: Text('Settings'),
//             onTap: () {
//               // Navigate to settings screen
//             },
//           ),
//           ListTile(
//             title: Text('Sync Config'),
//             onTap: () {
//               // Navigate to sync configuration
//             },
//           ),
//           ListTile(
//             title: Text('App Version: 1.0.0'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// The main content area that shows assignments with a toolbar for filtering and view toggling.
// class AssignmentContentArea extends StatefulWidget {
//   const AssignmentContentArea({Key? key}) : super(key: key);
//
//   @override
//   _AssignmentContentAreaState createState() => _AssignmentContentAreaState();
// }
//
// class _AssignmentContentAreaState extends State<AssignmentContentArea> {
//   bool isTableView = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Top toolbar with a search field, filter button, and view toggle button.
//         Container(
//           padding: EdgeInsets.all(8.0),
//           color: Colors.blueGrey[50],
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search Assignments...',
//                     border: OutlineInputBorder(),
//                     isDense: true,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.filter_list),
//                 onPressed: () {
//                   // Open a filter dialog or panel.
//                 },
//               ),
//               IconButton(
//                 icon: Icon(isTableView ? Icons.view_list : Icons.table_chart),
//                 onPressed: () {
//                   setState(() {
//                     isTableView = !isTableView;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         // Main content: either a table or card view.
//         Expanded(
//           child: isTableView ? AssignmentTableView() : AssignmentCardView(),
//         ),
//       ],
//     );
//   }
// }
//
// /// A skeleton for an assignment table view using DataTable.
// class AssignmentTableView extends StatelessWidget {
//   const AssignmentTableView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Wrap DataTable in SingleChildScrollView for horizontal scrolling.
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columns: [
//           DataColumn(label: Text('Assignment')),
//           DataColumn(label: Text('Status')),
//           DataColumn(label: Text('Details')),
//         ],
//         rows: List.generate(
//           10,
//           (index) => DataRow(
//             cells: [
//               DataCell(Text('Assignment $index')),
//               DataCell(Text('Status $index')),
//               DataCell(
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     // Open form selection dialog.
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// A skeleton for an assignment card view.
// class AssignmentCardView extends StatelessWidget {
//   const AssignmentCardView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.all(8.0),
//           child: ListTile(
//             title: Text('Assignment $index'),
//             subtitle: Text('Status $index'),
//             trailing: IconButton(
//               icon: Icon(Icons.edit),
//               onPressed: () {
//                 // Open form selection dialog.
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
