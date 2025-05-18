import 'package:auto_route/annotations.dart';
import 'package:datarunmobile/app_routes/app_routes.dart';
import 'package:datarunmobile/core/sync/model/resource_progress.data.dart';
import 'package:datarunmobile/core/sync/model/resource_state.dart';
import 'package:datarunmobile/core/sync/model/sync_state.dart';
import 'package:datarunmobile/core/sync/model/sync_status.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/sync/presentation/sync_with_server_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SyncProgressView extends StackedView<SyncProgressViewModel> {
  const SyncProgressView({super.key, this.onResult});

  final Function(bool didFinish)? onResult;

  @override
  Widget builder(
      BuildContext context, SyncProgressViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildGlobalProgress(viewModel.state),
            const SizedBox(height: 16),
            ElevatedButton.icon(
                onPressed: () => appLocator<AppRouter>().replace(HomeRoute()),
                icon: const Icon(Icons.document_scanner),
                label: const Text('NAVIGATE TO HOME')),
            const SizedBox(height: 16),
            _buildResourceList(viewModel.state, viewModel, context),
            if (viewModel.state?.error != null)
              _buildErrorState(viewModel.state?.error, viewModel),
          ],
        ),
      ),
    );
  }

  @override
  SyncProgressViewModel viewModelBuilder(BuildContext context) =>
      SyncProgressViewModel(onResult: onResult);

  @override
  void onViewModelReady(SyncProgressViewModel viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.triggerSync());

  Widget _buildGlobalProgress(SyncState? state) {
    return Center(
      child: SizedBox(
        width: 75,
        height: 75,
        child: LinearProgressIndicator(
          value: state?.percentage ?? 0 / 100,
          // Defaults to 0.5.
          valueColor: AlwaysStoppedAnimation(
              _getStatusColor(state?.status ?? SyncStatus.idle)),
          // Defaults to the current Theme's accentColor.
          backgroundColor: Colors.grey[200],
          // Defaults to the current Theme's backgroundColor.
          // borderColor: Colors.red,
          // borderWidth: 5.0,
          // direction: Axis.vertical,
          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
          // center: Text('${state?.totalResources ?? 0} Resources...'),
        ),
      ),
    );
  }

  Widget _buildResourceList(
      SyncState? state, SyncProgressViewModel viewModel, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Current Operations:'),
        ...state?.resourceHistory
                .map((p) => _buildResourceItem(p, viewModel, context)) ??
            [],
      ],
    );
  }

  Widget _buildResourceItem(ResourceProgress progress,
      SyncProgressViewModel viewModel, BuildContext context) {
    return ListTile(
      leading: _getStateIcon(progress.state, progress.resourceName, viewModel),
      title: Text(progress.resourceName),
      subtitle: _buildResourceSubtitle(progress, context),
      trailing: Text(
        DateFormat.Hms().format(progress.timestamp),
      ),
    );
  }

  Widget _buildResourceSubtitle(
      ResourceProgress progress, BuildContext context) {
    return switch (progress.state) {
      ResourceStarting() => const Text('Starting sync...'),
      ResourceSucceeded s => Row(
          children: [
            Text(
              '${s.itemsDownloaded}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            horizontalSpaceSmall,
            Text('${progress.resourceName} downloaded'),
          ],
        ),
      ResourceFailed(:final error) => Text('Error: ${error.toString()}'),
    };
  }

  Widget _getStateIcon(ResourceState state, String resourceName,
      SyncProgressViewModel viewModel) {
    return switch (state) {
      ResourceStarting() => const Icon(Icons.autorenew, color: Colors.blue),
      ResourceSucceeded() => IconButton(
          icon: const Icon(Icons.autorenew, color: Colors.green),
          onPressed: () => viewModel.retryOneResource(resourceName),
        ),
      ResourceFailed() => IconButton(
          icon: const Icon(Icons.autorenew, color: Colors.orange),
          onPressed: () => viewModel.retryOneResource(resourceName),
        ),
    };
  }

  Color _getStatusColor(SyncStatus status) {
    return switch (status) {
      SyncStatus.idle => Colors.grey,
      SyncStatus.starting => Colors.blue,
      SyncStatus.running => Colors.blue,
      SyncStatus.complete => Colors.green,
      SyncStatus.failed => Colors.red,
    };
  }

  Widget _buildErrorState(Object? object, SyncProgressViewModel viewModel) {
    return Column(
      children: [
        Text('${object.toString()}'),
        ElevatedButton.icon(
            // onPressed: () =>
            //     appLocator<AppRouter>().replace(HomeRoute()),
            onPressed: () => viewModel.triggerSync(),
            icon: const Icon(Icons.document_scanner),
            label: Text(S.current.ok))
      ],
    );
  }
}
