// import 'package:flutter/material.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// // final GlobalKey<NavigatorState>? navigatorKey = StackedService.navigatorKey;
//
// final GlobalKey<NavigatorState> dashboardKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> productsKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();
//
// // extension NavigatorKeyUtils on GlobalKey<NavigatorState> {
// //   L get localization {
// //     return L.of(currentContext!)!;
// //   }
// // }
// // Navigator.of(navigatorKey.currentContext!, rootNavigator: false)
// //     .pushNamed(route, arguments: arguments);
// Future<void> navigate(BuildContext? context, String route,
//         {bool isDialog = false,
//         bool isRootNavigator = true,
//         Map<String, dynamic>? arguments}) =>
//     Navigator.of(context ?? navigatorKey!.currentContext!,
//             rootNavigator: isRootNavigator)
//         .pushNamed(route, arguments: arguments);
//
// Future<void> navigatePush(Widget page,
//         {bool isDialog = false,
//         bool isRootNavigator = true,
//         Map<String, dynamic>? arguments,
//         BuildContext? context}) =>
//     Navigator.push(
//       context ?? navigatorKey!.currentContext!,
//       MaterialPageRoute(builder: (context) => page),
//     );
//
// // void logout(BuildContext context) {
// //   // Clear user session or token here
// //   Navigator.of(context).pushAndRemoveUntil(
// //     MaterialPageRoute(builder: (context) => LoginScreen()),
// //     (Route<dynamic> route) => false,
// //   );
// // }
//
// void pushUniqueScreen(BuildContext context, String routeName,
//     {dynamic arguments}) {
//   bool isRouteActive = false;
//   Navigator.popUntil(context, (route) {
//     if (route.settings.name == routeName) {
//       isRouteActive = true;
//     }
//     return true;
//   });
//
//   if (!isRouteActive) {
//     Navigator.pushNamed(context, routeName, arguments: arguments);
//   }
// }
//
// /// Color list
// const Color mediumPurple = Color.fromRGBO(79, 0, 241, 1.0);
// List<Color> colors = <Color>[mediumPurple, Colors.orange, Colors.teal];
