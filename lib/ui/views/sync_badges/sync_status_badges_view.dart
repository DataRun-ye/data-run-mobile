import 'package:datarunmobile/commons/custom_widgets/flutter_loading.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/sync_status_aggregator/sync_status_aggregator.dart';
import 'package:datarunmobile/data_run/d_assignment/assignment_detail/sync_status_icon.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/get_error_widget.dart';
import 'package:datarunmobile/ui/views/sync_badges/sync_badges_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SyncStatusBadgesView extends StatelessWidget {
  SyncStatusBadgesView(
      {super.key, required this.id, required this.aggregationLevel});

  final String id;
  final AggregationLevel aggregationLevel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SyncBadgesViewModel>.reactive(
      builder: (context, model, child) => FlutterLoading(
        isLoading: model.isBusy,
        color: Colors.green,
        child: Wrap(
          spacing: 8,
          children: model.hasError
              ? [
                  getErrorWidget(model.modelError, null,
                      message: model.modelMessage)
                ]
              : model.data!.entries
                  .where((e) => e.value > 0)
                  .map<Widget>((e) =>
                      _SyncStatusBadge(syncStatus: e.key, count: e.value))
                  .toList(),
        ),
      ),
      viewModelBuilder: () =>
          SyncBadgesViewModel(aggregationLevel: aggregationLevel, id: id),
    );
  }
}

class _SyncStatusBadge extends StatelessWidget {
  const _SyncStatusBadge({required this.syncStatus, required this.count});

  final SyncStatus syncStatus;
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
