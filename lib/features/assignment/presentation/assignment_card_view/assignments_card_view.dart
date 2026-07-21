import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/assignment/application/assignment_filter.provider.dart';
import 'package:datarunmobile/features/assignment/presentation/assignment_card_view/assignment_overview_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentsCardView extends ConsumerWidget {
  const AssignmentsCardView({
    super.key,
    required this.activityId,
    required this.onViewDetails,
  });

  final String activityId;
  final void Function(AssignmentModel) onViewDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider(activityId));

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return ListView.builder(
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final assignment = assignments[index];
            return AssignmentOverviewItem(
              assignment: assignment,
              onViewDetails: onViewDetails,
            );
          },
        );
      },
    );
  }
}
