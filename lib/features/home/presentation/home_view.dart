import 'package:auto_route/annotations.dart';
import 'package:datarunmobile/app/router/app_router.dart';
import 'package:datarunmobile/app/router/app_router.gr.dart';
import 'package:datarunmobile/commons/custom_widgets/flutter_loading.dart';
import 'package:datarunmobile/core/network/online_connectivity.provider.dart';
import 'package:datarunmobile/data_run/d_activity/activity_page.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/home/presentation/internet_aware_screen.dart';
import 'package:datarunmobile/features/home/presentation/presentation.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.refresh = false});

  static String routeName = '/home';

  final bool refresh;

  @override
  Widget build(BuildContext context) {
    // final appAboutAsync = ref.watch(appAboutInfoProvider);
    // final activitiesAsync = ref.watch(activitiesProvider);
    final router = appLocator<AppRouter>();
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Consumer(
          builder: (
            BuildContext context,
            WidgetRef ref,
            Widget? child,
          ) {
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
                    FlutterLoading(
                      isLoading: viewModel.busy(viewModel.user),
                      child: UserAccountsDrawerHeader(
                        accountName: Text(viewModel.user?.firstName ?? '-'),
                        accountEmail: Text(viewModel.user?.username ?? '-'),
                        currentAccountPicture: CircleAvatar(
                          child: Text(
                              viewModel.user?.firstName?.substring(0, 1) ??
                                  '-'),
                        ),
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
                        // router.back();
                        router.navigate(const SettingsRoute());

                        // Navigator.push(
                        //     navigatorKey.currentContext!,
                        //     MaterialPageRoute(
                        //       builder: (context) => const SettingsPage(),
                        //     ));
                      },
                    ),
                    const Divider(),
                    const DrawerSyncItem(),
                    const Divider(),
                    const AppVersionInfoWidget(),
                  ],
                ),
              ),
              body: const ActivityPage(), // Main content
            );
          },
        );
      },
    );
  }

// @override
// void initState() {
// final sessionData = currentAuthUser;
// if (sessionData.langKey !=
//     ref.read(preferenceNotifierProvider(Preference.language))) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     ref
//         .read(preferenceNotifierProvider(Preference.language).notifier)
//         .update(sessionData.langKey);
//   });
// }
//
// super.initState();
// }

// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//   if (widget.refresh) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.invalidate(activitiesProvider);
//     });
//   }
// }
}
