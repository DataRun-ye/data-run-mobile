// import 'package:datarunmobile/data_run/form/form_state/form_state.data.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final fieldStateProvider = StateProvider.family<FieldState, String>((ref, path) {
//   final formState = ref.watch(formStateProvider);
//   return formState.fields[path]!;
// });
//
// void updateFieldInRiverpod(String path, dynamic value, WidgetRef ref) {
//   ref.read(fieldStateProvider(path).notifier).update((state) => state.copyWith(value: value));
// }
//
//
