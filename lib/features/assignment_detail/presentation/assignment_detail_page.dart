import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/status_aggregation_level.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_label_with_icon.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/form_display.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/team_display.dart';
import 'package:datarunmobile/features/assignment/presentation/build_status.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/details_submissions_table.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/features/form/application/form_template_model.dart';
import 'package:datarunmobile/features/form/presentation/form_submission_create.widget.dart';
import 'package:datarunmobile/features/form_submission/application/submission_list.provider.dart';
import 'package:datarunmobile/features/form_ui_elements/presentation/get_error_widget.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssignmentDetailPage extends ConsumerWidget {
  AssignmentDetailPage({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Wrap(
          spacing: 3,
          children: [
            Text(S.of(context).assignmentDetail),
            VerticalDivider(color: cs.onPrimary),
            TeamDisplay(team: assignment.team, row: true),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEntityInfo(assignment, '', context),
            const SizedBox(height: 32.0),
            HighlightedLabelWithIcon(
                Icons.document_scanner,
                assignment.availableForms.length == assignment.userForms.length
                    ? '(${S.of(context).form(assignment.availableForms.length)})'
                    : '(${assignment.availableForms.length}/${S.of(context).form(assignment.userForms.length)})',
                ''),
            // Form Submissions Section
            const SizedBox(height: 20.0),
            Divider(),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => const Divider(
                    height: 0,
                    // thickness: 0.5,
                    indent: 16,
                    endIndent: 16,
                  ),
                  itemCount: assignment.availableForms.length,
                  itemBuilder: (BuildContext context, int index) {
                    final form = assignment.availableForms[index].first;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _EagerInitialization(
                        child: ExpansionTile(
                          collapsedBackgroundColor: cs.surfaceContainerHigh,
                          dense: true,
                          title: FormDisplay(form: form.form),
                          visualDensity: VisualDensity.standard,
                          subtitle: SyncStatusBadgesView(
                              id: form.form,
                              aggregationLevel: StatusAggregationLevel.form,
                              assignmentId: form.assignment),
                          children: [
                            DetailSubmissionsTable(
                              index: index,
                              assignment: assignment,
                              formId: form.form,
                            )
                          ],
                        ),
                        assignment: assignment,
                        formId: form.form,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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

class _FormListItem extends ConsumerWidget {
  const _FormListItem(
      {required this.index, required this.assignmentForm, required this.onTap});

  final int index;
  final AssignmentForm assignmentForm;
  final void Function(FormTemplateModel) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formTemplateAsync = ref.watch(
        submissionVersionFormTemplateProvider(formId: assignmentForm.form));
    final theme = Theme.of(context);
    final metadataStyle =
        theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700);
    final cs = Theme.of(context).colorScheme;
    return AsyncValueWidget(
      value: formTemplateAsync,
      valueBuilder: (formTemplate) {
        final cs = Theme.of(context).colorScheme;
        return ListTile(
          // tileColor: cs.surfaceContainerHigh.withValues(alpha: .7),
          iconColor: cs.primary,
          // textColor: cs.onSurfaceVariant,
          titleTextStyle: Theme.of(context).textTheme.titleSmall,
          subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
          isThreeLine: true,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: const Icon(Icons.description)),
              SizedBox(
                height: 2,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('v${formTemplate.versionNumber}',
                    style: metadataStyle),
              ),
            ],
          ),
          title: Text(
              '${index + 1}. ${getItemLocalString(formTemplate.label, defaultString: formTemplate.name)}'),
          subtitle: SyncStatusBadgesView(
              id: formTemplate.id,
              aggregationLevel: StatusAggregationLevel.form,
              assignmentId: assignmentForm.assignment),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hoverColor: cs.onSurface.withValues(alpha: 0.1),
        );
      },
    );
  }
}
