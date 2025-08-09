import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/common/confirmation_service.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/features/data_instance/application/table.providers.dart';
import 'package:datarunmobile/features/data_instance/application/table_controller.provider.dart';
import 'package:datarunmobile/features/data_instance/presentation/table_widget.dart';
import 'package:datarunmobile/features/data_instance/presentation/widgets/action_fab.dart';
import 'package:datarunmobile/features/data_instance/presentation/widgets/filter_bar.dart';
import 'package:datarunmobile/features/data_instance/presentation/widgets/filter_drawer.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/features/sync_badges/sync_status_badges_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

class TableScreen extends ConsumerWidget {
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
    final filter = ref.watch(dataInstanceFilterProvider(
      formId: formId,
      assignmentId: assignmentId,
    ));

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
              final filters = ref.watch(dataInstanceFilterProvider(
                formId: formId,
                assignmentId: assignmentId,
              ));
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
        ],
      ),
      floatingActionButton: ActionFAB(
        onAddNew: () {
          appLocator<NavigationService>().navigateToFormFlowBootstrapper(
              formId: formId, assignmentId: assignmentId);
        },
        onDelete: () {
          appLocator<ConfirmationService>().confirmAndExecute(
              context: context,
              title: S.of(context).confirm,
              body: S.of(context).deleteConfirmationMessage,
              confirmLabel: S.of(context).delete,
              action: () => ref
                  .read(tableControllerProvider.notifier)
                  .deleteSelectedItems());
        },
        onBulkSync: () {
          logDebug('onSync');
          ref
              .read(tableControllerProvider.notifier)
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
