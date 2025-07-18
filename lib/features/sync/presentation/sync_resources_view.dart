import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/features/sync/presentation/sync_progress_circular_indicator.dart';
import 'package:datarunmobile/features/sync/presentation/sync_resources_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SyncResourcesView extends StackedView<SyncResourcesViewModel> {
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
