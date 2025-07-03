import 'package:datarunmobile/app_router/app_router.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/data/preference2.provider.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/home/home.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:timeago/timeago.dart' as timeago;

class DrawerSyncItem extends ViewModelWidget<HomeViewModel> {
  const DrawerSyncItem({
    super.key,
  }) : super(reactive: true);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Consumer(builder: (
      BuildContext context,
      WidgetRef ref,
      Widget? child,
    ) {
      final syncMetadataRepo = appLocator<SyncMetadataRepository>();
      final lastSyncTime = syncMetadataRepo.lastSyncTime;
      final router = appLocator<AppRouter>();
      final language =
          ref.watch(preferenceNotifierProvider(Preference.language));
      String lastSynced = lastSyncTime != null
          ? timeago.format(lastSyncTime.toLocal(), locale: language)
          : S.of(context).noSyncYet;
      if (model.busy(model.isOnline))
        return const Center(child: CircularProgressIndicator());
      final isOnline = model.isOnline;
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
                router.pushSync();
              }
            : null,
      );
    });
  }
}
