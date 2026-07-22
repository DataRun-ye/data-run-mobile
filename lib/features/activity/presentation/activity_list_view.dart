import 'package:datarunmobile/features/activity/application/activity_list.provider.dart';
import 'package:datarunmobile/features/activity/presentation/activity_card.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_screen.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityListView extends ConsumerWidget {
  const ActivityListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(activityListProvider).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => Center(child: Text(S.of(context).noActivitiesYet)),
          data: (activities) {
            final enabled =
                activities.where((activity) => !activity.disabled).toList();
            if (enabled.isEmpty) {
              return Center(child: Text(S.of(context).noActivitiesYet));
            }

            return ListView.builder(
              itemCount: enabled.length,
              itemBuilder: (context, index) {
                final activity = enabled[index];
                return ActivityCard(
                  activity: activity,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AssignmentScreen(
                          activityId: activity.id,
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
