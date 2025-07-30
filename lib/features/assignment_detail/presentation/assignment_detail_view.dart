import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/assignment_model.dart';
import 'package:d_sdk/database/shared/status_aggregation_level.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_by_value_label.dart';
import 'package:datarunmobile/commons/custom_widgets/highlighted_label_with_icon.dart';
import 'package:datarunmobile/features/assignment/presentation/assignments_table/team_display.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_page.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/assignment_detail_viewmodel.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/features/form/application/form_template_model.dart';
import 'package:datarunmobile/features/form_ui_elements/presentation/get_error_widget.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AssignmentDetailView extends ConsumerWidget {
  AssignmentDetailView({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return ViewModelBuilder<AssignmentDetailViewModel>.reactive(
      viewModelBuilder: () => AssignmentDetailViewModel(assignmentId)..run(),
      builder: (context, model, child) {
        if (model.isBusy)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (model.hasError) return getErrorWidget(model.modelError, null);

        final assignment = model.assignment!;
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
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                Flexible(
                    child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => const Divider(
                          height: 4,
                          thickness: 0.5,
                          indent: 16,
                          endIndent: 16,
                        ),
                        itemCount: assignment.availableForms.length,
                        itemBuilder: (BuildContext context, int index) {
                          final AssignmentForm form =
                              assignment.availableForms[index].first;
                          return _FormListItem(
                              index: index,
                              assignmentForm: form,
                              onTap: (template) {
                                appLocator<NavigationService>()
                                    .navigateToSubmissionHistoryScreen(
                                        form: template.id);
                              });
                        },
                      )),
                )),
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
      },
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

class _FormListItem extends ConsumerWidget {
  const _FormListItem(
      {required this.index, required this.assignmentForm, required this.onTap});

  final int index;
  final AssignmentForm assignmentForm;
  final void Function(FormTemplateModel) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formTemplateAsync = ref.watch(
        formTemplateProvider(formId: assignmentForm.form));
    final theme = Theme.of(context);
    final metadataStyle =
        theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700);
    final cs = Theme.of(context).colorScheme;
    return AsyncValueWidget(
      value: formTemplateAsync,
      valueBuilder: (formTemplate) {
        final cs = Theme.of(context).colorScheme;
        return ListTile(
          tileColor: cs.surfaceContainerHigh.withValues(alpha: .7),
          iconColor: cs.primary,
          textColor: cs.onSurfaceVariant,
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
          isThreeLine: formTemplate.description != null,
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
              aggregationLevel: StatusAggregationLevel.form),
          enableFeedback: true,
          onTap: () => onTap(formTemplate),
          trailing: const Icon(Icons.chevron_right),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hoverColor: cs.onSurface.withValues(alpha: 0.1),
        );
      },
    );
  }
}
