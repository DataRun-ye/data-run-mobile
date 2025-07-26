import 'package:d_sdk/core/sync/model/sync_progress_event.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/sync_manager/sync_resource_status.dart';
import 'package:datarunmobile/features/sync/presentation/sync_progress_circular_indicator.dart';
import 'package:datarunmobile/features/sync/presentation/sync_resources_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SyncResourcesView extends StackedView<SyncResourcesViewModel> {
  @override
  Widget builder(
      BuildContext context, SyncResourcesViewModel viewModel, Widget? child) {
    final items = viewModel.resourceStates.values.toList();
    final global = viewModel.globalState;
    final cs = Theme.of(context).colorScheme;
    final ButtonStyle overrideFocusColor = ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return states.contains(WidgetState.focused)
            ? cs.primaryContainer
            : cs.primaryContainer;
      }),
    );

    return Scaffold(
      // appBar: AppBar(title: Text('Sync Status')),
      body: SafeArea(
        child: ColoredBox(
          color: cs.primary,
          child: Column(
            children: [
              if (global != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
                  child: SyncProgressCircularIndicator(
                    syncProgressInfo: global,
                  ),
                ),
                ElevatedButton(
                  style: overrideFocusColor,
                  onPressed: () {
                    appLocator<NavigationService>().clearStackAndShow(
                      Routes.homeWrapperPage,
                    );
                  },
                  child: Text(S.of(context).cancelSyncing),
                ),
              ],
              // Expanded list of individual resources
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, i) => _AnimatedGridSyncCard(
                    status: items[i],
                    delay: Duration(milliseconds: 100 * i),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SyncResourcesViewModel viewModelBuilder(BuildContext context) =>
      SyncResourcesViewModel();

  @override
  void onViewModelReady(SyncResourcesViewModel viewModel) {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => viewModel.triggerSync());
  }
}

class _AnimatedGridSyncCard extends StatefulWidget {
  const _AnimatedGridSyncCard({
    Key? key,
    required this.status,
    required this.delay,
  }) : super(key: key);
  final SyncResourceStatus status;
  final Duration delay;

  @override
  _AnimatedGridSyncCardState createState() => _AnimatedGridSyncCardState();
}

class _AnimatedGridSyncCardState extends State<_AnimatedGridSyncCard> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = widget.status.state == SyncProgressState.SUCCEEDED;
    final isError = widget.status.state == SyncProgressState.FAILED;
    final cs = Theme.of(context).colorScheme;
    final accentColor = isSuccess
        ? cs.onSurfaceVariant
        : isError
            ? cs.error
            : Theme.of(context).colorScheme.primary;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: _visible ? 1 : 0,
      child: Card(
        color: cs.surfaceDim,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 8, 9, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                isSuccess
                    ? Icons.check_circle
                    : isError
                        ? Icons.error
                        : Icons.sync,
                size: 18,
                color: accentColor,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  Intl.message(widget.status.name),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 13.0, fontWeight: FontWeight.bold),
                ),
              ),
              TweenAnimationBuilder<int>(
                tween: IntTween(
                  begin: 0,
                  end: widget.status.syncedResources ?? 0,
                ),
                duration: const Duration(milliseconds: 600),
                builder: (context, value, _) => Text(
                  '$value',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
