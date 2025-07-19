import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_label_with_icon.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/team_display.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/form/presentation/form_submission_create.widget.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/form_submissions_table.dart';
import 'package:datarunmobile/features/form_ui_elements/presentation/get_error_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentDetailPage extends ConsumerWidget {
  AssignmentDetailPage({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final activityModel = ActivityInheritedWidget.of(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).assignmentDetail),
            VerticalDivider(color: cs.onPrimary),
            TeamDisplay(team: assignment.team, row: true),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildEntityInfo(assignment, '', context),
              const SizedBox(height: 32.0),
              HighlightedLabelWithIcon(
                  Icons.document_scanner,
                  assignment.availableForms.length ==
                          assignment.userForms.length
                      ? '(${S.of(context).form(assignment.availableForms.length)})'
                      : '(${assignment.availableForms.length}/${S.of(context).form(assignment.userForms.length)})',
                  ''),
              // Form Submissions Section
              const SizedBox(height: 20.0),
              Divider(),
              ...assignment.availableForms
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _EagerInitialization(
                        child: FormSubmissionsTable(
                          index: entry.key,
                          assignment: assignment,
                          formId: entry.value.first.form,
                        ),
                        assignment: assignment,
                        formId: entry.value.first.form,
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: assignment.availableForms.length > 0
            ? () async {
                await showFormSelectionBottomSheet(context, assignment);
              }
            : null,
        child: const Icon(Icons.document_scanner),
        tooltip: S.of(context).openNewForm,
      ),
    );
  }

  Widget _buildEntityInfo(
      AssignmentModel assignment, String searchQuery, BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.location_on),
        const SizedBox(width: 4),
        HighlightedByValueLabel(
            '${assignment.orgUnit.code ?? ''}-${assignment.orgUnit.name}',
            searchQuery,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
      ],
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

Future<void> showFormSelectionBottomSheet(
    BuildContext context, AssignmentModel assignment) async {
  final cs = Theme.of(context).colorScheme;
  try {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return FormSubmissionCreate(
          assignment: assignment,
          onNewFormCreated: (createdSubmission) async {
            Navigator.of(context).pop();
            goToDataEntryForm(context, assignment, createdSubmission);
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
