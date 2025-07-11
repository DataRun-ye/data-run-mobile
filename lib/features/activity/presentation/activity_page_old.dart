import 'package:d_sdk/database/shared/activity_model.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/features/activity/presentation/activity_card.dart';
import 'package:datarunmobile/features/activity/presentation/activity_inherited_widget.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_page_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(activitiesProvider);
    return AsyncValueWidget(
      value: activitiesAsync,
      valueBuilder: (List<ActivityModel> activities) {
        return ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return ActivityCard(
              activity: activity,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProviderScope(
                      overrides: [
                        activityModelProvider.overrideWithValue(activity)
                      ],
                      child: ActivityInheritedWidget(
                          activityModel: activity,
                          child: const AssignmentPage()),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
