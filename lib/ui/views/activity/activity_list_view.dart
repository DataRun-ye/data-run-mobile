// import 'package:datarunmobile/data/activity/activity.provider.dart'
//     show activityModelProvider;
// import 'package:datarunmobile/data_run/d_activity/activity_inherited_widget.dart';
// import 'package:datarunmobile/data_run/d_assignment/assignment_page_new.dart';
// import 'package:datarunmobile/ui/views/activity/activity_card_view.dart';
// import 'package:datarunmobile/ui/views/activity/activity_list_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:stacked/stacked.dart';
//
// class ActivityListView extends ConsumerWidget {
//   const ActivityListView({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ViewModelBuilder<ActivityListViewModel>.reactive(
//         viewModelBuilder: () => ActivityListViewModel(),
//         builder: (context, model, child) {
//           return ListView.builder(
//             itemCount: activities.length,
//             itemBuilder: (context, index) {
//               final activity = activities[index];
//               return ActivityCardView(
//                 activityId: activity,
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => ProviderScope(
//                         overrides: [
//                           activityModelProvider.overrideWithValue(activity)
//                         ],
//                         child: ActivityInheritedWidget(
//                             activityModel: activity,
//                             child: const AssignmentPageNew()),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         });
//   }
// }
