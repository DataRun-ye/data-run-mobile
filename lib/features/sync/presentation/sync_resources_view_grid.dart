import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/core/sync_manager/sync_resource_status.dart';
import 'package:datarunmobile/features/sync/presentation/sync_progress_circular_indicator.dart';
import 'package:datarunmobile/features/sync/presentation/sync_resources_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SyncResourcesView extends StackedView<SyncResourcesViewModel> {
  @override
  Widget builder(BuildContext context, viewModel, child) {
    final items = viewModel.resourceStates.values.toList();
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).syncProgressDashboard)),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => Divider(height: 0),
        itemBuilder: (context, i) {
          final res = items[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _SyncTile(key: ValueKey(res.name), status: res),
            ),
          );
        },
      ),
    );
  }

  @override
  SyncResourcesViewModel viewModelBuilder(BuildContext context) =>
      SyncResourcesViewModel();

  @override
  void onViewModelReady(SyncResourcesViewModel viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.triggerSync());
}

class _SyncTile extends StatelessWidget {
  const _SyncTile({Key? key, required this.status}) : super(key: key);
  final SyncResourceStatus status;

  @override
  Widget build(BuildContext context) {
    final icon = status.state == SyncProgressState.SUCCEEDED
        ? Icons.check_circle
        : status.state == SyncProgressState.FAILED
            ? Icons.error
            : Icons.sync;

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(8),
      child: ListTile(
        dense: true,
        leading: Icon(icon, size: 20),
        title: Text(status.name, style: TextStyle(fontSize: 14)),
        trailing: Text(
          '${status.syncedResources ?? ''}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _SyncResourcesView extends StackedView<SyncResourcesViewModel> {
  @override
  Widget builder(
      BuildContext context, SyncResourcesViewModel viewModel, Widget? child) {
    final global = viewModel.globalState;
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surfaceContainer,
      appBar: AppBar(
        title: Text(S.of(context).syncProgressDashboard),
      ),
      body: Column(
        children: [
          // Global indicator
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SyncProgressCircularIndicator(
              syncProgressInfo: global,
            ),
          ),
          Divider(),
          // Detailed list of resource statuses
          Expanded(
            child: ListView.separated(
              itemCount: viewModel.resourceStates.length,
              separatorBuilder: (_, __) => Divider(
                color: cs.primary,
                thickness: 0.2,
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final res =
                    viewModel.resourceStates.entries.toList()[index].value;
                return ListTile(
                  leading: Icon(
                    res.state == SyncProgressState.SUCCEEDED
                        ? Icons.check_circle
                        : res.state == SyncProgressState.FAILED
                            ? Icons.error
                            : Icons.sync,
                    color: res.state == SyncProgressState.SUCCEEDED
                        ? Colors.green
                        : res.state == SyncProgressState.FAILED
                            ? Colors.red
                            : cs.primary,
                  ),
                  title: Text(Intl.message(res.name),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      )),
                  trailing: Text(res.syncedResources?.toString() ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  SyncResourcesViewModel viewModelBuilder(BuildContext context) =>
      SyncResourcesViewModel();

  @override
  void onViewModelReady(SyncResourcesViewModel viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.triggerSync());
}
