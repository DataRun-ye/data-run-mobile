import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:d_sdk/database/shared/activity_model.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/home/activity/presentation/activity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ActivityListPage extends ConsumerWidget {
  const ActivityListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(activitiesProvider);
    return AsyncValueWidget<List<ActivityModel>>(
      value: activitiesAsync,
      valueBuilder: (activities) {
        return ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return ActivityCard(
              activity: activity,
              onTap: () {
                // context.router.navigate(
                //   AssignmentsRouteRoute.routeName,
                //   extra: activity,
                // );

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => ProviderScope(
                //       overrides: [
                //         activityModelProvider.overrideWithValue(activity)
                //       ],
                //       child: ActivityInheritedWidget(
                //           activityModel: activity,
                //           child: const AssignmentListView()),
                //     ),
                //   ),
                // );
              },
            );
          },
        );
      },
    );
  }
}
