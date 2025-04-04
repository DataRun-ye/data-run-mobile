// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// class ActivityListView extends ConsumerWidget {
//   const ActivityListView({super.key, required this.activities});
//
//   final List<ActivityModel> activities;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListView.builder(
//       itemCount: activities.length,
//       itemBuilder: (context, index) {
//         final activity = activities[index];
//         return ActivityCard(
//           activity: activity,
//           onTap: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ProviderScope(
//                   overrides: [
//                     activityModelProvider.overrideWithValue(activity)
//                   ],
//                   child: ActivityInheritedWidget(
//                       activityModel: activity,
//                       child: const AssignmentPageNew()),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
