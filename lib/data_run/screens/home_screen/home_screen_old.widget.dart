import 'package:d_sdk/database/shared/activity_model.dart';
import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/core/auth/auth.provider.dart';
import 'package:datarunmobile/core/network/online_connectivity.provider.dart';
import 'package:datarunmobile/core/services/user_session_manager.service.dart';
import 'package:datarunmobile/data/activity/activity.provider.dart';
import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/data/preference.provider.dart';
import 'package:datarunmobile/data_run/d_activity/activity_page_old.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/stacked/app.router.dart';
import 'package:datarunmobile/utils/color_scheme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

@Deprecated('replaced with HomeWrapperPage')
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.refresh = false});

  final bool refresh;

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends ConsumerState<HomeScreen> {
  final _navigationService = appLocator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final userInfoAsync = ref.watch(userInfoProvider);
    final appAboutAsync = ref.watch(appAboutInfoProvider);
    final cs = Theme.of(context).colorScheme;
    return AsyncValueWidget(
      value: userInfoAsync,
      valueBuilder: (userInfo) {
        final activitiesAsync = ref.watch(activitiesProvider);
        return AsyncValueWidget(
          value: activitiesAsync,
          valueBuilder: (List<ActivityModel> activities) {
            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).home),
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
                      decoration: BoxDecoration(
                        color: cs.isDark ? cs.onSecondary : cs.primary,
                      ),
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
                        _navigationService.navigateToSettingsView();

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
              body: ActivityPage(), // Main content
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
    final _navigationService = appLocator<NavigationService>();
    final userSessionManager = appLocator<UserSessionService>();
    final lastSyncTime = userSessionManager.lastSyncTime;

    return AsyncValueWidget(
      value: ref.watch(isOnlineProvider),
      valueBuilder: (bool isOnline) {
        String lastSynced = lastSyncTime != null
            ? timeago.format(lastSyncTime.toLocal(),
                locale:
                    ref.watch(preferenceNotifierProvider(Preference.language))
                        as String?)
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
              : Icon(MdiIcons.webOff, color: Colors.grey),
          onTap: isOnline
              ? () {
                  _navigationService.back();
                  _navigationService.replaceWithSyncProgressView();

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
