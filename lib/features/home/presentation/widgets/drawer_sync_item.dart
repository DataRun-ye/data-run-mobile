import 'package:datarunmobile/app_routes/app_routes.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/network/online_connectivity.provider.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/data/preference2.provider.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class DrawerSyncItem extends ConsumerWidget {
  const DrawerSyncItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final syncMetadataRepo = ref.watch(userSessionManagerProvider);
    final syncMetadataRepo = appLocator<SyncMetadataRepository>();
    final lastSyncTime = syncMetadataRepo.lastSyncTime;
    final router = appLocator<AppRouter>();

    final language = ref.watch(preferenceNotifierProvider(Preference.language));
    return AsyncValueWidget(
      value: ref.watch(isOnlineProvider),
      valueBuilder: (bool isOnline) {
        String lastSynced = lastSyncTime != null
            ? timeago.format(lastSyncTime.toLocal(), locale: language)
            : S.of(context).noSyncYet;
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
                  // router.back();
                  router.navigate(SyncProgressRoute());
                  // Navigator.pop(context);
                  //       Navigator.push(
                  //         navigatorKey.currentContext!,
                  //         MaterialPageRoute(builder: (context) => const SyncScreen()),
                  //       );
                }
              : null,
        );
      },
    );
  }
}
