import 'package:datarun/data_run/d_activity/activity_card.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_activity/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datarun/data_run/d_assignment/assignment_page.dart';

import 'activity_model.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key, required this.activities});

  final List<ActivityModel> activities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      activityModel: activity, child: const AssignmentPage()),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
