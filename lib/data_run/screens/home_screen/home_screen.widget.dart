import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/app/app.router.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/auth/auth.provider.dart';
import 'package:datarunmobile/core/auth/internet_aware_screen.dart';
import 'package:datarunmobile/core/network/online_connectivity.provider.dart';
import 'package:datarunmobile/core/services/user_session_manager.service.dart';
import 'package:datarunmobile/data_run/d_activity/activity_model.dart';
import 'package:datarunmobile/data_run/d_activity/activity_page.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/data/preference.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.refresh = false});

  static String routeName = '/';

  final bool refresh;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreen> {
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final userInfoAsync = ref.watch(userInfoProvider);
    final appAboutAsync = ref.watch(appAboutInfoProvider);
    return AsyncValueWidget(
      value: userInfoAsync,
      valueBuilder: (userInfo) {
        final activitiesAsync = ref.watch(activitiesProvider);

        return AsyncValueWidget(
          value: activitiesAsync,
          valueBuilder: (List<ActivityModel> activities) {
            return Scaffold(
              appBar: InternetAwareAppBar(
                title: S.of(context).home,
              ),
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
                      accountName: Text(userInfo?.firstName ?? '-'),
                      accountEmail: Text(userInfo?.username ?? '-'),
                      currentAccountPicture: CircleAvatar(
                        child: Text(userInfo?.firstName?.substring(0, 1) ?? ''),
                      ),
                    ),
                    ListTile(
                      style: ListTileStyle.drawer,
                      leading: const Icon(Icons.settings),
                      title: Text(S.of(context).settings),
                      onTap: () {
                        // Navigator.pop(context);
                        _navigationService.back();
                        _navigationService.navigateToSettingsPage();

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
                          subtitle: Text(
                              '${appInfo.version} (${appInfo.buildNumber})'),
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
      },
    );
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
    // final userSessionManager = ref.watch(userSessionManagerProvider);
    final _navigationService = locator<NavigationService>();
    final userSessionManager = locator<UserSessionService>();
    final lastSyncTime = userSessionManager.lastSyncTime;

    return AsyncValueWidget(
      value: ref.watch(isOnlineProvider),
      valueBuilder: (bool isOnline) {
        String lastSynced = lastSyncTime != null
            ? timeago.format(lastSyncTime.toLocal(),
                locale:
                    ref.watch(preferenceNotifierProvider(Preference.language)))
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
                  color:
                      userSessionManager.syncDone ? Colors.green : Colors.red)
              : const Icon(MdiIcons.webOff, color: Colors.grey),
          onTap: isOnline
              ? () {
                  _navigationService.back();
                  _navigationService.replaceWithSyncScreen();

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
