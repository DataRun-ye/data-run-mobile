import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/features/home/presentation/drawer/about_page.dart';
import 'package:datarunmobile/features/settings/presentation/appearance_tab.dart';
import 'package:datarunmobile/features/settings/presentation/sync_tab_view.dart';
import 'package:datarunmobile/features/settings/presentation/user_settings_tab_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends StatelessWidget {
  const SettingsView();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settings),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.person),
                text: S.of(context).userSettings,
              ),
              Tab(
                icon: const Icon(Icons.sync),
                text: S.of(context).syncSettings,
              ),
              Tab(
                icon: const Icon(Icons.color_lens),
                text: S.of(context).appearance,
              ),
              Tab(
                icon: const Icon(Icons.info),
                text: S.of(context).about,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              const UserSettingsTabView(),
              const SyncSettingTabView(),
              const AppearanceTab(),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final appAboutAsync = ref.watch(appAboutInfoProvider);
                  return AsyncValueWidget(
                    value: appAboutAsync,
                    valueBuilder: (AppAbout appAbout) =>
                        AboutPage(appAbout: appAbout),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
