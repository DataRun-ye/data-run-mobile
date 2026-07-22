import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/dao/data_submissions_dao.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';

extension DataInstancesDaoExpressionExtension on DataInstancesDao {
  Future<FormTemplateModel> getTemplateByVersionOrLatest(
      {String? templateId, String? versionId}) async {
    assert(templateId != null || versionId != null);
    var query = attachedDatabase.managers.formTemplateVersions
        .withReferences((prefetch) => prefetch(template: true));

    if (versionId != null) {
      query = query.filter((f) => f.id(versionId));
    } else {
      query = query.filter((f) => f.template.id(templateId));
    }

    final List<(FormTemplateVersion, $$FormTemplateVersionsTableReferences)>
        formTemplateWithRefs =
        await query.orderBy((o) => o.versionNumber.desc()).limit(1).get();
    final (templateVersion, refs) = formTemplateWithRefs.first;

    final formTemplate = refs.template.prefetchedData!.first;

    return FormTemplateModel(
      id: formTemplate.id,
      name: formTemplate.name,
      versionUid: templateVersion.id,
      label: formTemplate.label,
      disabled: formTemplate.disabled ?? false,
      description: formTemplate.description,
      versionNumber: templateVersion.versionNumber,
      fields: templateVersion.fields.build(),
      sections: templateVersion.sections.build(),
      options: (templateVersion.options ?? []).build(),
    );
  }
}
