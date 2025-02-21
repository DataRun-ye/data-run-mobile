// import 'package:datarun/core/element_instance/form_state_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// class ResponsiveFormScreen extends ConsumerWidget {
//   // You might pass your form model/data here
//   const ResponsiveFormScreen({Key? key, required this.submission})
//       : super(key: key);
//
//   final String submission;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Decide on a breakpoint for desktop layout.
//     final formStateAsync = ref.watch(formStateNotifierProvider);
//
//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth > 1200) {
//         return DesktopFormLayout(
//             elements: rootElements, stateManager: stateManager);
//       } else {
//         return MobileFormLayout(
//             elements: rootElements, stateManager: stateManager);
//       }
//     });
//   }
// }
