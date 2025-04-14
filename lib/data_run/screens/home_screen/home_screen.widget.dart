import 'package:auto_route/annotations.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:datarunmobile/app_routing/app_route.dart';
import 'package:datarunmobile/app_routing/app_route.gr.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/network/online_connectivity.provider.dart';
import 'package:datarunmobile/core/sync/sync_metadata_repository.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/data/preference2.provider.dart';
import 'package:datarunmobile/data_run/d_activity/activity_model.dart';
import 'package:datarunmobile/data_run/d_activity/activity_page.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.refresh = false});

  static String routeName = '/';

  final bool refresh;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreen> {
  final _navigationService = appLocator<NavigationService>();
  final currentAuthUser = DSdk.currentAuthUser;

  @override
  Widget build(BuildContext context) {
    final appAboutAsync = ref.watch(appAboutInfoProvider);
    final activitiesAsync = ref.watch(activitiesProvider);
    final router = appLocator<AppRouter>();

    return AsyncValueWidget(
      value: activitiesAsync,
      valueBuilder: (List<ActivityModel> activities) {
        return Scaffold(
          onDrawerChanged: (isOpen) {
            final hasValue = ref.read(isOnlineProvider).hasValue;
            isOpen && hasValue
                ? ref.read(isOnlineProvider.notifier).check()
                : null;
          },
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(currentAuthUser.firstname),
                  accountEmail: Text(currentAuthUser.username),
                  currentAccountPicture: CircleAvatar(
                    child: Text(currentAuthUser.firstname.substring(0, 1)),
                  ),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: const Icon(Icons.settings),
                  title: Text(S.of(context).settings),
                  onTap: () {
                    // Navigator.pop(context);
                    // _navigationService.back();
                    // _navigationService.navigateToSettingsPage();
                    router.back();
                    router.navigate(const SettingsRoute());

                    // Navigator.push(
                    //     navigatorKey.currentContext!,
                    //     MaterialPageRoute(
                    //       builder: (context) => const SettingsPage(),
                    //     ));
                  },
                ),
                const Divider(),
                const SyncButton(),
                const Divider(),
                AsyncValueWidget(
                  value: appAboutAsync,
                  valueBuilder: (AppAbout appInfo) {
                    return ListTile(
                      leading: const Icon(Icons.info),
                      title: Text(S.of(context).appVersion),
                      subtitle:
                          Text('${appInfo.version} (${appInfo.buildNumber})'),
                    );
                  },
                ),
              ],
            ),
          ),
          body: ActivityPage(
            activities: activities,
          ), // Main content
        );
      },
    );
  }

  @override
  void initState() {
    final sessionData = currentAuthUser;
    if (sessionData.langKey !=
        ref.read(preferenceNotifierProvider(Preference.language))) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(preferenceNotifierProvider(Preference.language).notifier)
            .update(sessionData.langKey);
      });
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.refresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.invalidate(activitiesProvider);
      });
    }
  }
}

class SyncButton extends ConsumerWidget {
  const SyncButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final syncMetadataRepo = ref.watch(userSessionManagerProvider);
    final _navigationService = appLocator<NavigationService>();
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
                  router.back();
                  router.navigate(const SyncProgressRoute());
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
