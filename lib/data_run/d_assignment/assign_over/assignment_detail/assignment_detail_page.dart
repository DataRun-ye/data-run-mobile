import 'package:datarun/data_run/d_activity/activity_card.dart';
import 'package:datarun/data_run/d_activity/activity_inherited_widget.dart';
import 'package:datarun/data_run/d_assignment/assign_over/assignment_detail/form_submissions_table.dart';
import 'package:datarun/data_run/d_assignment/assign_over/form_submission_create.widget.dart';
import 'package:datarun/data_run/d_assignment/model/assignment_provider.dart';
import 'package:datarun/data_run/d_assignment/test_/assignment_page.dart';
import 'package:datarun/data_run/form/form_submission/submission_list.provider.dart';
import 'package:datarun/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

class AssignmentDetailPage extends ConsumerWidget {
  const AssignmentDetailPage({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityModel = ActivityInheritedWidget.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).assignmentDetail),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(context),
              const SizedBox(height: 16.0),
              const Divider(thickness: 1.0),

              // Details Section
              const SizedBox(height: 16.0),
              _buildDetails(context),
              const SizedBox(height: 16.0),
              const Divider(thickness: 1.0),

              // Resources Comparison Section
              const SizedBox(height: 16.0),
              _buildResourcesComparison(context),
              const SizedBox(height: 16.0),
              const Divider(thickness: 1.0),

              // Actions Section
              const SizedBox(height: 16.0),
              _buildActions(context, ref, activityModel),

              // Form Submissions Section
              const SizedBox(height: 20.0),
              ...assignment.forms
                  .distinct()
                  .where((form) => activityModel.assignedForms.contains(form))
                  .map(
                    (form) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _EagerInitialization(
                        child: FormSubmissionsTable(
                          assignment: assignment,
                          formId: form,
                        ),
                        assignment: assignment,
                        formId: form,
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            assignment.activity,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        buildStatusBadge(assignment.status),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(context, S.of(context).entity,
            '${assignment.entityCode} - ${assignment.entityName}'),
        _buildDetailRow(context, S.of(context).team, '${assignment.teamCode}'),
        _buildDetailRow(
            context, S.of(context).scope, assignment.scope.name.toLowerCase()),
        if (assignment.dueDate != null)
          _buildDetailRow(context, S.of(context).dueDate,
              formatDate(assignment.dueDate!, context)),
        if (assignment.rescheduledDate != null)
          _buildDetailRow(context, S.of(context).rescheduled,
              formatDate(assignment.rescheduledDate!, context)),
        _buildDetailRow(
            context, S.of(context).forms, assignment.forms.length.toString()),
      ],
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
        const SizedBox(height: 8),
        ...assignment.allocatedResources.keys.map((key) {
          final allocated = assignment.allocatedResources[key] ?? 0;
          final reported = assignment.reportedResources[key.toLowerCase()] ?? 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Intl.message(key.toLowerCase()),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '$reported / $allocated',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildActions(
      BuildContext context, WidgetRef ref, ActivityModel activityModel) {
    return ElevatedButton.icon(
      onPressed: () async {
        await showFormSelectionBottomSheet(context, assignment, activityModel);
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

class _EagerInitialization extends ConsumerWidget {
  _EagerInitialization(
      {required this.child, required this.assignment, required this.formId});

  final Widget child;
  final AssignmentModel assignment;
  final String formId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formInstance = ref.watch(formSubmissionsProvider(formId));
    if (formInstance.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (formInstance.hasError) {
      return getErrorWidget(formInstance.error, formInstance.stackTrace);
    }

    return child;
  }
}

Future<void> showFormSelectionBottomSheet(BuildContext context,
    AssignmentModel assignment, ActivityModel activityModel) async {
  try {
    await showModalBottomSheet(
      // isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return ActivityInheritedWidget(
          activityModel: activityModel,
          child: FormSubmissionCreate(
            assignment: assignment,
            onNewFormCreated: (createdSubmission) async {
              Navigator.of(context).pop();
              goToDataEntryForm(
                  context, assignment, createdSubmission, activityModel);
              // ref.invalidate(assignmentsProvider);
            },
          ),
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
