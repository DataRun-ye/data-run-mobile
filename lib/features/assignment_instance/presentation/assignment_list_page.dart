import 'package:datarunmobile/features/assignment_instance/presentation/assignment_list_page_viewmodel.dart';
import 'package:datarunmobile/features/assignment_instance/presentation/assignment_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked.dart';

class AssignmentListPage extends ConsumerWidget {
  @override
  Widget build(_, ref) {
    return ViewModelBuilder<AssignmentListPageViewModel>.reactive(
        viewModelBuilder: () => AssignmentListPageViewModel(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return const Center(child: CircularProgressIndicator());
          }
          if (model.hasError) {
            return Center(child: Text(model.modelError!));
          }
          return ListView(
            children: model.items
                .map((a) =>
                AssignmentTile(
                      assignment: a,
                      // onViewDetails: (assignment) {},
                    ))
                .toList(),
          );
        });
  }
}
