import 'package:datarun/modular/activity_module/activity/activity_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ActivityListView extends StackedView<ActivityListViewModel> {
  const ActivityListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ActivityListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text('ActivityListView')),
      ),
    );
  }

  @override
  ActivityListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ActivityListViewModel();
}
