// import 'package:auto_route/auto_route.dart';
// import 'package:datarunmobile/app_routes/app_routes.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:datarunmobile/home/dashboard/presentation/settings/settings.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// @RoutePage()
// class SettingsWrapperPage extends StatelessWidget {
//   const SettingsWrapperPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AutoTabsRouter.tabBar(
//       routes: const [
//         UserSettingsTabRoute(),
//         SyncSettingTabRoute(),
//         AppearanceTabRoute(),
//         AboutTabRoute(),
//       ],
//       builder: (context, child, animation) {
//         final tabsRouter = AutoTabsRouter.of(context);
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(S.of(context).settings),
//             bottom: TabBar(
//               onTap: tabsRouter.setActiveIndex,
//               tabs: [
//                 Tab(
//                   icon: const Icon(Icons.person),
//                   text: S.of(context).userSettings,
//                 ),
//                 Tab(
//                   icon: Icon(MdiIcons.update),
//                   text: S.of(context).syncSettings,
//                 ),
//                 Tab(
//                   icon: const Icon(Icons.color_lens),
//                   text: S.of(context).appearance,
//                 ),
//                 Tab(
//                   icon: const Icon(Icons.info),
//                   text: S.of(context).about,
//                 ),
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [
//               UserSettingsTabView(),
//               SyncSettingTabView(),
//               AppearanceTabView(),
//               AboutTabView(),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
