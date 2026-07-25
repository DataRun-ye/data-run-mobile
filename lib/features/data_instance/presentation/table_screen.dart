import 'package:datarunmobile/core/form/element_template/get_item_local_string.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/common/confirmation_service.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/features/data_instance/application/submission_table_service.dart';
import 'package:datarunmobile/features/data_instance/application/table_controller.provider.dart';
import 'package:datarunmobile/features/data_instance/presentation/table_widget.dart';
import 'package:datarunmobile/features/data_instance/presentation/widgets/action_fab.dart';
import 'package:datarunmobile/features/data_instance/presentation/widgets/filter_bar.dart';
import 'package:datarunmobile/features/data_instance/presentation/widgets/filter_drawer.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class TableScreen extends HookConsumerWidget {
  const TableScreen({
    super.key,
    required this.formId,
    this.assignmentId,
  });

  final String formId;
  final String? assignmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).userSavedInstances),
      ),
      endDrawer: FilterDrawer(
        formId: formId,
        assignmentId: assignmentId,
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final formAsync = ref.watch(formTemplateProvider(formId: formId));
              return AsyncValueWidget(
                value: formAsync,
                valueBuilder: (templateModel) {
                  return Expanded(
                    child: PaginatedItemsTable(
                      disabledCellColor: WidgetStateProperty.all(
                          darken(cs.surfaceContainerHighest, 0.1)),
                      templateModel: templateModel,
                      assignmentId: assignmentId,
                      header: Row(
                        children: [
                          Expanded(
                            child: Text(
                              getItemLocalString(templateModel.label,
                                  defaultString: templateModel.name),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SyncStatusBadgesView(
                              formId: formId, assignmentId: assignmentId),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
      floatingActionButton: ActionFAB(
        formId: formId,
        assignmentId: assignmentId,
        onAddNew: () {
          appLocator<NavigationService>().navigateToFormFlowBootstrapper(
              formId: formId, assignmentId: assignmentId);
        },
        onDelete: () async {
          final controller = ref.read(tableControllerProvider(
            formId: formId,
            assignmentId: assignmentId,
          ).notifier);
          final canDelete = await controller.canDeleteSelectedItems();
          if (!context.mounted) return;
          if (!canDelete) {
            _showProtectedDeletionMessage(context);
            return;
          }

          appLocator<ConfirmationService>().confirmAndExecute(
              context: context,
              title: S.of(context).confirm,
              body: S.of(context).confirmDeleteItemsSelected(ref
                  .read(tableControllerProvider(
                    formId: formId,
                    assignmentId: assignmentId,
                  ))
                  .length),
              confirmLabel: S.of(context).delete,
              action: () async {
                final result = await controller.deleteSelectedItems();
                if (context.mounted &&
                    result ==
                        LocalSubmissionDeletionResult
                            .blockedByServerRetention) {
                  _showProtectedDeletionMessage(context);
                }
              });
        },
        onBulkSync: () {
          ref
              .read(tableControllerProvider(
                formId: formId,
                assignmentId: assignmentId,
              ).notifier)
              .syncSelectedFinalizedItems();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      persistentFooterButtons: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FilterBar(
              formId: formId,
              assignmentId: assignmentId,
            )),
      ],
      persistentFooterAlignment: AlignmentDirectional.centerEnd,
    );
  }
}

void _showProtectedDeletionMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(S.of(context).serverRetainedSubmissionsCannotBeDeleted),
    ),
  );
}
