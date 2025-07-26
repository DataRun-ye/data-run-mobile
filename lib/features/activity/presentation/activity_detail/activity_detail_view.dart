import 'package:datarunmobile/features/activity/presentation/activity_detail/activity_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ActivityDetailView extends StackedView<ActivityDetailViewModel> {
  const ActivityDetailView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ActivityDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: const Center(child: Text('ActivityDetailView')),
        ),
      ),
    );
  }

  @override
  ActivityDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ActivityDetailViewModel();
}
