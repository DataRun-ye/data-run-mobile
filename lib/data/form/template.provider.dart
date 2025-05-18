// import 'package:d_sdk/d_sdk.dart';
// import 'package:d_sdk/database/app_database.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'template.provider.g.dart';
//
// @riverpod
// FutureOr<FormVersion> formVersionAsync(FormVersionAsyncRef ref,
//     {required String form, required int version}) async {
//   final template = await DSdk.db.managers.formVersions
//       .filter((f) => f.id('${form}_$version'))
//       .getSingleOrNull();
//   // await D2Remote.formModule.formTemplateV.byId('${form}_$version').getOne();
//
//   return template!;
// }
