import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/assignment/assignment.provider.dart';
import 'package:datarunmobile/data/assignment/assignment_model.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_list_card_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentListCardView extends ConsumerWidget {
  const AssignmentListCardView(
      {super.key, required this.onViewDetails, this.selectionList = false});

  final bool selectionList;
  final void Function(String id)? onViewDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider);

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return ListView.builder(
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final assignment = assignments[index];
            return ProviderScope(
                overrides: [assignmentProvider.overrideWithValue(assignment)],
                child: AssignmentListCardViewItem(
                  onViewDetails: (assignment) =>
                      onViewDetails?.call(assignment.id),
                ));
          },
        );
      },
    );
  }
}
