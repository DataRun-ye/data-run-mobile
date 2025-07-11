// import 'package:datarunmobile/commons/custom_widgets/async_value.widget.dart';
// import 'package:datarunmobile/data_run/screens/home_screen/drawer/about_page.dart';
// import 'package:datarunmobile/data/app_about_info.provider.dart';
// import 'package:datarunmobile/data_run/screens/home_screen/drawer/appearance_settings_tab.dart';
// import 'package:datarunmobile/data_run/screens/home_screen/drawer/sync_setting_page.dart';
// import 'package:datarunmobile/data_run/screens/home_screen/drawer/user_settings_tab.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// class SettingsPage extends ConsumerWidget {
//   const SettingsPage();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appAboutAsync = ref.watch(appAboutInfoProvider);
//
//     return AsyncValueWidget(
//       value: appAboutAsync,
//       valueBuilder: (AppAbout appAbout) {
//         return DefaultTabController(
//           length: 4,
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text(S.of(context).settings),
//               bottom: TabBar(
//                 tabs: [
//                   Tab(
//                     icon: const Icon(Icons.person),
//                     text: S.of(context).userSettings,
//                   ),
//                   Tab(
//                     icon: Icon(MdiIcons.update),
//                     text: S.of(context).syncSettings,
//                   ),
//                   Tab(
//                     icon: const Icon(Icons.color_lens),
//                     text: S.of(context).appearance,
//                   ),
//                   Tab(
//                     icon: const Icon(Icons.info),
//                     text: S.of(context).about,
//                   ),
//                 ],
//               ),
//             ),
//             body: TabBarView(
//               children: [
//                 const UserSettingsTab(),
//                 const SyncSettingTab(),
//                 const AppearanceSettingsTab(),
//                 AboutPage(
//                   appAbout: appAbout,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
