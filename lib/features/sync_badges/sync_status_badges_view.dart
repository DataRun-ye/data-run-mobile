import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/status_icon.dart';
import 'package:datarunmobile/features/sync_badges/sync_badges_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SyncStatusBadgesView extends StatelessWidget {
  SyncStatusBadgesView(
      {super.key, required this.id, required this.aggregationLevel});

  final String id;
  final StatusAggregationLevel aggregationLevel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SyncBadgesViewModel>.reactive(
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Wrap(
              spacing: 2,
              runSpacing: 2,
              alignment: WrapAlignment.end,
              children: model.data
                      ?.where((e) => e.count > 0)
                      .map<Widget>((e) => _SyncStatusBadge(
                          syncStatus: e.syncState, count: e.count))
                      .toList() ??
                  [],
            ),
      viewModelBuilder: () =>
          SyncBadgesViewModel(aggregationLevel: aggregationLevel, id: id),
    );
  }
}

class _SyncStatusBadge extends StatelessWidget {
  const _SyncStatusBadge({required this.syncStatus, required this.count});

  final InstanceSyncStatus syncStatus;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 2.0),
        child: Column(children: [
          StatusIcon(syncState: syncStatus),
          const SizedBox(width: 4),
          Text('$count', style: Theme.of(context).textTheme.bodyMedium)
        ]));
  }
}
