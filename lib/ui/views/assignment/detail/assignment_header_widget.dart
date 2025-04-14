// import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
// import 'package:datarunmobile/data_run/d_assignment/build_status.dart';
// import 'package:flutter/material.dart';
//
// class AssignmentHeaderWidget extends StatelessWidget {
//   const AssignmentHeaderWidget({super.key, required this.assignment});
//
//   final AssignmentModelNew assignment;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             assignment.activity.displayName!,
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
