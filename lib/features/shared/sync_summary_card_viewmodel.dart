import 'package:d_sdk/core/logging/new_app_logging.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:stacked/stacked.dart';

class SyncSummaryCardViewmodel extends BaseViewModel {
  List<SyncSummary> syncSummaries = [];

  void run() async {
    syncSummaries = await runBusyFuture(DSdk.db.managers.syncSummaries.get());
  }

  @override
  void dispose() {
    super.dispose();
    logDebug('dispose SyncSummaryCardViewmodel');
  }
}
