import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
import 'package:datarunmobile/data/app_about_info.provider.dart';
import 'package:datarunmobile/features/home/presentation/drawer/about_page.dart';
import 'package:datarunmobile/features/settings/presentation/appearance_tab.dart';
import 'package:datarunmobile/features/settings/presentation/settings_viewmodel.dart';
import 'package:datarunmobile/features/settings/presentation/sync_tab_view.dart';
import 'package:datarunmobile/features/settings/presentation/user_settings_tab_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StackedView<SettingsViewmodel> {
  const SettingsView();

  @override
  Widget builder(
      BuildContext context, SettingsViewmodel viewModel, Widget? child) {
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
                icon: Icon(MdiIcons.update),
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

  @override
  SettingsViewmodel viewModelBuilder(BuildContext context) =>
      SettingsViewmodel();
}
