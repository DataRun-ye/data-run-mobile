import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:d_sdk/database/shared/status_aggregation_level.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_label_with_icon.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/form_display.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/form_prefix_version_badge.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/team_display.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/features/form/presentation/form_submission_create.widget.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked_services/stacked_services.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const Divider(
                      height: 0,
                      thickness: 0.2,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemCount: assignment.availableForms.length,
                    itemBuilder: (BuildContext context, int index) {
                      final form = assignment.availableForms[index].first;

                      return ListTile(
                        leading: FormPrefixVersionBadge(form: form.form),
                        title: FormDisplay(form: form.form),
                        subtitle: SyncStatusBadgesView(
                            id: form.form,
                            aggregationLevel: StatusAggregationLevel.form,
                            assignmentId: form.assignment),
                        trailing: AnimatedRotation(
                          turns: 0.5,
                          duration: const Duration(milliseconds: 300),
                          child: SvgPicture.asset(
                              'assets/app/icon_expansion_tile.svg'),
                        ),
                        onTap: () {
                          appLocator<NavigationService>()
                              .navigateToDataInstanceTableScreen(
                                  formId: form.form,
                                  assignment: form.assignment);
                        },
                      );

                      // return TableExpansible(form: form);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: assignment.availableForms.length > 0
            ? () async {
                await showFormSelectionBottomSheet(context, assignment.id);
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

Future<void> showFormSelectionBottomSheet(
    BuildContext context, String assignmentId) async {
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
          assignmentId: assignmentId,
          onTap: (templateId) async {
            Navigator.of(context).pop();
            appLocator<NavigationService>().navigateToFormFlowBootstrapper(
              formId: templateId,
              assignmentId: assignmentId,
              parameters: {
                'formId': templateId,
                'assignmentId': assignmentId,
              },
            );
            // goToDataEntryForm(context, assignment, createdSubmission);
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
    final formTemplateAsync =
        ref.watch(formTemplateProvider(formId: assignmentForm.form));
    final theme = Theme.of(context);
    final metadataStyle =
        theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700);
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      leading: FormPrefixVersionBadge(form: assignmentForm.form),
      title: FormDisplay(form: assignmentForm.form),
      subtitle: SyncStatusBadgesView(
          id: assignmentForm.form,
          aggregationLevel: StatusAggregationLevel.form,
          assignmentId: assignmentForm.assignment),
      trailing: SvgPicture.asset('assets/app/icon_expansion_tile.svg'),
    );
  }
}
