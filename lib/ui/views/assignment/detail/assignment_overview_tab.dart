import 'package:datarunmobile/commons/custom_widgets/copy_to_clipboard.dart';
import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
import 'package:datarunmobile/data_run/d_activity/activity_card.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_detail/assignment_detail_page.dart';
import 'package:datarunmobile/data_run/d_assignment/model/assignment_model.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/ui/views/assignment/detail/assignment_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AssignmentOverviewTab extends StatelessWidget {
  const AssignmentOverviewTab({super.key, required this.assignment});

  final String assignment;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignmentDetailViewModel>.reactive(
      viewModelBuilder: () => AssignmentDetailViewModel(assignment),
      builder: (context, model, child) {
        if (model.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }
        if (model.hasError) {
          return Center(child: Text(model.modelError!));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CopyToClipboard(
                value: model.assignment!.orgUnit.code,
                child: _buildDetailRow(context, S.of(context).entity,
                    '${model.assignment!.orgUnit.code} - ${model.assignment!.orgUnit.displayName}')),
            _buildDetailRow(
                context, S.of(context).team, '${model.assignment!.team.code}'),
            _buildDetailRow(context, S.of(context).scope,
                model.assignment!.scope.name.toLowerCase()),
            if (model.assignment!.dueDate != null)
              _buildDetailRow(context, S.of(context).dueDate,
                  formatDate(model.assignment!.dueDate!, context)),
            _buildDetailRow(context, S.of(context).forms,
                model.linkedForms.length.toString()),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesComparison(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).resources,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, AssignmentDetailViewModel model) {
    return ElevatedButton.icon(
      onPressed: () async {
        await model.showBasicBottomSheet();
        // await showFormSelectionBottomSheet(context, assignment, activityModel);
      },
      icon: const Icon(Icons.document_scanner),
      label: Text(
        S.of(context).openNewForm,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

Future<void> showCreateSubmissionSheet(
    BuildContext context, AssignmentModel assignment) async {
  try {
    await showModalBottomSheet(
      // isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return FormSubmissionCreate(
          assignment: assignment,
          onNewFormCreated: (createdSubmission) async {
            Navigator.of(context).pop();
            goToDataEntryForm(
                context, assignment, createdSubmission, activityModel);
            // ref.invalidate(assignmentsProvider);
          },
        );
      },
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${S.of(context).errorOpeningForm}: ${e.toString().substring(0, 50)}'),
        duration: const Duration(seconds: 2),
      ),
    );
    return;
  }
}

