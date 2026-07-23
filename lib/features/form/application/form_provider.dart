import 'package:datarunmobile/database/shared/form_template_model.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/data/form_template_list_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_provider.g.dart';

/// form id could be on the format of formId-version or formId
/// look for the latest version of the form template or the form template
/// that matches the version
@riverpod
Future<FormTemplateModel> formTemplate(Ref ref,
    {String? formId, String? versionId}) async {
  final form = await appLocator<FormTemplateListService>()
      .getTemplateByVersionOrLatest(templateId: formId, versionId: versionId);
  return form;
}
