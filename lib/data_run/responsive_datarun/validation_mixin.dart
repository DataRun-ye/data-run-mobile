// mixin ValidationMixin on FormElementWidget {
//   Widget buildWithValidation(Widget child) {
//     return Consumer<FormStateManager>(
//         builder: (context, manager, _) {
//           final state = manager.getState(element);
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               child,
//               if (state.error != null)
//                 ErrorText(error: state.error!)
//             ],
//           );
//         }
//     );
//   }
// }
//
// class ErrorText extends StatelessWidget {
//   final String error;
//
//   Widget build(BuildContext context) {
//     return Text(
//       error,
//       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//           color: Theme.of(context).colorScheme.error
//       ),
//     );
//   }
// }