import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

class DrawerSyncItem extends StackedHookView<AppDrawerViewModel> {
  const DrawerSyncItem({
    super.key,
  }) : super(reactive: true);

  @override
  Widget builder(BuildContext context, AppDrawerViewModel model) {
    final syncMetadataRepo = appLocator<SyncMetadataRepository>();
    final lastSyncTime = syncMetadataRepo.lastSyncTime;
    String lastSynced = lastSyncTime != null
        ? timeago.format(lastSyncTime.toLocal(),
            locale: Intl.getCurrentLocale())
        : S.of(context).noSyncYet;

    if (model.isBusy) {
      return const Center(child: CircularProgressIndicator());
    }

    final isOnline = model.isOnline;

    // ConnectivityBuilder(
    //   onlineBuilder: (BuildContext, WidgetRef) => ,
    //   offlineBuilder: (BuildContext, WidgetRef) => NoConnectionIndicator(),
    // );

    return ListTile(
      isThreeLine: true,
      style: ListTileStyle.drawer,
      leading: const Icon(Icons.sync),
      title: Text(S.of(context).fetchUpdates),
      subtitle: Text(
        '${S.of(context).lastSync}:\n '
        '$lastSynced',
        softWrap: true,
      ),
      trailing: isOnline
          ? Icon(Icons.check_circle,
              color: syncMetadataRepo.isInitialSyncDone
                  ? Colors.green
                  : Colors.red)
          : Icon(MdiIcons.webOff, color: Colors.grey),
      onTap: isOnline
          ? () {
        appLocator<NavigationService>().back();
        appLocator<NavigationService>().replaceWithSyncResourcesView();
      }
          : null,
    );
  }
}
