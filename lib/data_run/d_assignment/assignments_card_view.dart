import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/assignment/assignment_model.provider.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_overview_item_new.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/data/activity/assignment.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentsCardView extends ConsumerWidget {
  const AssignmentsCardView(
      {super.key, required this.onViewDetails, this.scope});

  final void Function(AssignmentModel) onViewDetails;
  final EntityScope? scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentsAsync = ref.watch(filterAssignmentsProvider(scope));

    return AsyncValueWidget(
      value: assignmentsAsync,
      valueBuilder: (assignments) {
        return ListView.builder(
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final assignment = assignments[index];
            return ProviderScope(
              overrides: [assignmentProvider.overrideWithValue(assignment)],
              child: AssignmentOverviewItem(
                // assignment: assignment,
                onViewDetails: (assignment) => onViewDetails(assignment),
                // onChangeStatus: (AssignmentStatus newStatus) {},
                // onFormSubmission: (createdSubmission) async {
                //   // pop bottomSheet
                //   Navigator.of(context).pop();
                //   // go to createdSubmission's form
                //   _goToDataEntryForm(
                //       context,
                //       FormMetadata(
                //           assignmentModel: assignment,
                //           submission: createdSubmission.id,
                //           formId: createdSubmission.formVersion));
                // }
              ),
            );
          },
        );
      },
    );
  }

  // void _goToDataEntryForm(
  //     BuildContext context, FormMetadata formMetadata) async {
  //   await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => FormMetadataWidget(
  //                 formMetadata: formMetadata,
  //                 child: const FormSubmissionScreen(currentPageIndex: 1),
  //               )));
  // }
}
