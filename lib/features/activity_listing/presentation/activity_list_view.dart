//
// import 'package:datarunmobile/data/activity/activity.provider.dart';
// import 'package:datarunmobile/home/activity/presentation/widgets/activity_inherited_widget.dart';
// import 'package:datarunmobile/features/activity_listing/presentation/activity_card_view.dart';
// import 'package:datarunmobile/features/activity_listing/presentation/activity_list_viewmodel.dart';
// import 'package:datarunmobile/features/assignment/presentation/assignment_page_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
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
//             itemCount: model.activities.length,
//             itemBuilder: (context, index) {
//               final activity = model.activities[index];
//               return ActivityCardView(
//                 activityId: activity.id,
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => ProviderScope(
//                         overrides: [
//                           activityModelProvider.overrideWithValue(activity)
//                         ],
//                         child: ActivityInheritedWidget(
//                             activityModel: activity,
//                             child: const AssignmentPageView()),
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
