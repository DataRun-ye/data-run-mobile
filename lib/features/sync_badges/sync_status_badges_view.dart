import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/home/assignment/presentation/sync_status_icon.dart';
import 'package:datarunmobile/features/sync_badges/sync_badges_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              spacing: 16,
              runSpacing: 8,
              children: model.data!
                  .where((e) => e.count > 0)
                  .map<Widget>((e) =>
                      _SyncStatusBadge(syncStatus: e.syncState, count: e.count))
                  .toList(),
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
    return Tooltip(
      message: Intl.message(syncStatus.name.toLowerCase()),
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 2.0),
          child: Column(children: [
            buildStatusIcon(syncStatus),
            const SizedBox(width: 4),
            Text('$count', style: Theme.of(context).textTheme.bodyMedium)
          ])),
    );
  }
}
