import 'package:datarunmobile/features/home/home.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/home/dashboard/presentation/widgets/drawer_app_version_item.dart';
import 'package:datarunmobile/home/dashboard/presentation/widgets/drawer_sync_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(viewModel.user?.firstName ?? '-'),
                accountEmail: Text(viewModel.user?.username ?? '-'),
                currentAccountPicture: CircleAvatar(
                  child:
                      Text(viewModel.user?.firstName?.substring(0, 1) ?? '-'),
                ),
              ),
              ListTile(
                style: ListTileStyle.drawer,
                leading: const Icon(Icons.settings),
                title: Text(S.of(context).settings),
                onTap: () {
                  // appLocator<AppRouter>().navigate(const SettingsRoute());
                },
              ),
              const Divider(),
              const DrawerSyncItem(),
              const Divider(),
              const DrawerAppVersionItem(),
            ],
          ),
        );
      },
    );
  }
}
