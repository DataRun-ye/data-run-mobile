// import 'package:d_sdk/d2_remote.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'template.provider.g.dart';
//
// @riverpod
// FutureOr<FormTemplateVersion> formVersionAsync(Ref ref,
//     {required String form, required int version}) async {
//   final template =
//       await D2Remote.formModule.formTemplateV
//           .where(attribute: 'formTemplate', value: form)
//           .where(attribute: 'versionNumber', value: version).getOne();
//
//   return template!;
// }
