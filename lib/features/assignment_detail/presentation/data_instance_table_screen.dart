import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/data_instance_table_vm.dart';
import 'package:datarunmobile/features/assignment_detail/presentation/data_instances_table_view.dart';
import 'package:datarunmobile/features/form/application/form_provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';

class DataInstanceTableScreen extends StackedView<DataInstanceTableVm> {
  const DataInstanceTableScreen({
    super.key,
    required this.formId,
    this.assignmentId,
    this.index,
  });

  final String formId;
  final String? assignmentId;
  final int? index;

  @override
  Widget builder(BuildContext context, DataInstanceTableVm vm, Widget? child) {
    return Consumer(
      builder: (context, ref, child) {
        final formAsync = ref.watch(formTemplateProvider(formId: formId));
        return AsyncValueWidget(
          value: formAsync,
          valueBuilder: (templateModel) {
            vm.templateModel = templateModel;
            return Scaffold(
              appBar: AppBar(
                title: Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: vm.getLabelString(templateModel.label,
                      defaultValue: templateModel.name),
                  child: Text(
                    vm.getLabelString(templateModel.label,
                        defaultValue: templateModel.name),
                    overflow: TextOverflow.ellipsis,
                    // style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                actions: [
                  // A Dropdown for filtering by sync status
                  // DropdownButton<InstanceSyncStatus>(
                  //   hint: Text(S.of(context).all),
                  //   value: vm.currentSyncStateFilter,
                  //   items: [
                  //     // 'All' option
                  //     DropdownMenuItem<InstanceSyncStatus>(
                  //       value: null,
                  //       child: Text(S.of(context).all),
                  //     ),
                  //     ...InstanceSyncStatus.values
                  //         .map((state) => DropdownMenuItem<InstanceSyncStatus>(
                  //               value: state,
                  //               child: Text(state.name),
                  //             )),
                  //   ],
                  //   onChanged: (newFilter) {
                  //     vm.filterBySyncState(newFilter);
                  //   },
                  // ),
                  // const SizedBox(width: 16),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataInstancesTableView(),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  vm.addNewInstance(formId, assignmentId);
                },
                child: const Icon(Icons.add),
                tooltip: S.of(context).openNewForm,
              ),
            );
          },
        );
      },
    );
  }

  @override
  DataInstanceTableVm viewModelBuilder(BuildContext context) {
    final vm = DataInstanceTableVm();
    vm.setParams(formId, assignmentId);
    return vm;
  }

  @override
  void onViewModelReady(DataInstanceTableVm viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.initialise());
}
