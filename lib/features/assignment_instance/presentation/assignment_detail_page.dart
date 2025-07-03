import 'package:datarunmobile/features/assignment_instance/presentation/assignment_detail_page_viewmodel.dart';
import 'package:datarunmobile/features/assignment_instance/presentation/stage_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';

class AssignmentDetailPage extends ConsumerWidget {
  AssignmentDetailPage({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  Widget build(_, ref) {
    return ViewModelBuilder<AssignmentDetailPageViewModel>.reactive(
        viewModelBuilder: () => AssignmentDetailPageViewModel(assignmentId),
        builder: (context, model, child) {
          if (model.isBusy) {
            return const Center(child: CircularProgressIndicator());
          }
          if (model.hasError) {
            return Center(child: Text(model.modelError!));
          }
          return Scaffold(
            appBar: AppBar(title: Text(model.assignment!.flowType)),
            body: StageNavigator(assignment: model.assignment!),
          );
        });
  }
}
