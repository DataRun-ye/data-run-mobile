import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun/form/entities/form_version.entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'template.providers.g.dart';

@riverpod
FutureOr<FormVersion> formVersionAsync(FormVersionAsyncRef ref,
    {required String form, required int version}) async {
  final template =
      await D2Remote.formModule.formTemplateV.byId('${form}_$version').getOne();

  return template!;
}
