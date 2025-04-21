// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:datarunmobile/ui/common/ui_helpers.dart';
// import 'package:flutter/material.dart';
//
// class LoginHeader extends StatelessWidget {
//   const LoginHeader({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 40, bottom: 20),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 Theme.of(context).dialogBackgroundColor,
//                 Theme.of(context).dialogBackgroundColor
//               ]),
//           boxShadow: const [
//             BoxShadow(
//                 offset: Offset.zero,
//                 spreadRadius: 0,
//                 blurRadius: .5,
//                 color: Colors.black)
//           ],
//           borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(40),
//               bottomRight: Radius.circular(40))),
//       child: Column(
//         children: [
//           Image.asset(
//             'assets/launcher_icon/logo_white.png',
//             height: 100,
//             width: 100,
//             // fit: BoxFit.contain,
//           ),
//           verticalSpaceSmall,
//           // if (AppEnvironment.isDev) const Text(AppEnvironment.apiBaseUrl),
//           // Spacer between logo and text
//           Text(
//             S.of(context).nmcpYemen,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color:
//                   Theme.of(context).primaryColorDark, // Match with logo color
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }
