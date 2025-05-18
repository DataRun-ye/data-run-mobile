// import 'package:d_sdk/database/shared/assignment_model.dart';
// import 'package:d_sdk/database/shared/assignment_status.dart';
// import 'package:d_sdk/database/shared/d_identifiable_model.dart';
// import 'package:datarunmobile/data_run/d_assignment/build_status.dart';
// import 'package:flutter/material.dart';
//
// class AssignmentHeaderWidget extends StatelessWidget {
//   const AssignmentHeaderWidget({super.key, required this.activity,
//     required this.status});
//
//   final IdentifiableModel activity;
//   final AssignmentStatus status;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             assignment.activity.name!,
//             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ),
//         buildStatusBadge(assignment.status),
//       ],
//     );
//   }
// }
