// import 'package:datarunmobile/features/common_ui_element/common/ui_helpers.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     final cs = Theme.of(context).colorScheme;
//
//     return Scaffold(
//       backgroundColor: cs.primary,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               S.of(context).datarun,
//               style: TextStyle(
//                   fontSize: 40, fontWeight: FontWeight.w900, color: cs.surface),
//             ),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(S.of(context).checkingSession,
//                     style: TextStyle(fontSize: 16, color: cs.surfaceDim)),
//                 horizontalSpaceSmall,
//                 SizedBox(
//                   width: 16,
//                   height: 16,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                         Colors.orangeAccent[400]!),
//                     strokeWidth: 6,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
