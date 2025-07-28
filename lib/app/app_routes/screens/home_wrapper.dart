// import 'package:datarunmobile/features/activity/presentation/activity_list_view.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class HomeWrapperPage extends StatelessWidget {
//   const HomeWrapperPage();
//
//   // final Widget child;
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text(S.of(context).home),
//         ),
//         drawer: AppDrawer(),
//         body: ActivityListView(),
//       );
// }
//
// class AppDrawer extends StatelessWidget {
//   final List<String> items = ['home', 'profile', 'settings'];
//
//   @override
//   Widget build(BuildContext c) {
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text('Drawer Header'),
//           ),
//           ListTile(
//             title: Text('Settings'),
//             onTap: () {
//               GoRouter.of(c).pushNamed('settings');
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext c) =>
//       Scaffold(body: Center(child: Text('HomePage')));
// }
