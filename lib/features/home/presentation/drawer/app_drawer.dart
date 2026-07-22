import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/app/theme/color_scheme_extension.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer_sync_item.dart';
import 'package:datarunmobile/features/home/presentation/drawer/app_drawer_version_item.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final user = appLocator<AuthManager>().activeUserSession;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: cs.isDark ? cs.onSecondary : cs.primary,
            ),
            accountName: Text(user?.firstName ?? '-'),
            accountEmail: Text(user?.username ?? '-'),
            currentAccountPicture: CircleAvatar(
              child: Text(user?.firstName?.substring(0, 1) ?? '-'),
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
}
