import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/app/theme/color_scheme_extension.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer_sync_item.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer_version_item.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer_viewmodel.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppDrawer extends StackedView<AppDrawerViewModel> {
  const AppDrawer({super.key});

  @override
  Widget builder(
    BuildContext context,
    AppDrawerViewModel model,
    Widget? child,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: cs.isDark ? cs.onSecondary : cs.primary,
            ),
            accountName: Text(model.user?.firstName ?? '-'),
            accountEmail: Text(model.user?.username ?? '-'),
            currentAccountPicture: CircleAvatar(
              child: Text(model.user?.firstName?.substring(0, 1) ?? '-'),
            ),
          ),
          ListTile(
            style: ListTileStyle.drawer,
            leading: const Icon(Icons.settings),
            title: Text(S.of(context).settings),
            onTap: () async {
              appLocator<NavigationService>().back();

              appLocator<NavigationService>().navigateToSettingsView();
            },
          ),
          const Divider(),
          const DrawerSyncItem(),
          const Divider(),
          const DrawerAppVersionItem(),
        ],
      ),
    );
  }

  @override
  void onViewModelReady(AppDrawerViewModel viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.checkOnline());

  @override
  AppDrawerViewModel viewModelBuilder(BuildContext context) =>
      AppDrawerViewModel();
}
