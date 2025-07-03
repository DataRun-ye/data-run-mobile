// import 'package:datarunmobile/data/assignment/assignment.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:datarunmobile/home/activity/presentation/widgets/activity_inherited_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class AssignmentDetailScreen extends ConsumerWidget {
//   const AssignmentDetailScreen({super.key, required this.assignment});
//
//   final String assignment;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final activityModel = ActivityInheritedWidget.of(context);
//     // final activityModel = ref.watch(activityModelProvider);
//     final assignmentModelAsync = ref.watch(assignmentProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(S.of(context).assignmentDetail),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [Text('AssignmentDetail of: $assignment')],
//           ),
//         ),
//       ),
//     );
//   }
// }
