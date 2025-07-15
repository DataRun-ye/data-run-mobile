import 'package:datarunmobile/features/activity/application/activity.provider.dart';
import 'package:datarunmobile/features/activity/presentation/activity_card.dart';
import 'package:datarunmobile/features/activity/presentation/activity_inherited_widget.dart';
import 'package:datarunmobile/features/activity/presentation/activity_list_viewmodel.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_page_new.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';

class ActivityListView extends StackedView<ActivityListViewModel> {
  const ActivityListView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ActivityListViewModel model, Widget? child) {
    if (model.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }
    final list = model.activities;
    if (list.isEmpty) {
      return Center(child: Text(S.of(context).noActivitiesYet));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final activity = list[index];
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

  @override
  ActivityListViewModel viewModelBuilder(BuildContext context) {
    return ActivityListViewModel();
  }

  @override
  void onViewModelReady(ActivityListViewModel viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.runFuture());
}
