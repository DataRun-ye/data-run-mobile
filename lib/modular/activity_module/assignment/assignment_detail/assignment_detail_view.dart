import 'package:datarunmobile/modular/activity_module/assignment/assignment_detail/assignment_detail_modelview.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AssignmentDetailView extends StackedView<AssignmentDetailViewModel> {
  const AssignmentDetailView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AssignmentDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text('AssignmentListView')),
      ),
    );
  }

  @override
  AssignmentDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AssignmentDetailViewModel();
}
