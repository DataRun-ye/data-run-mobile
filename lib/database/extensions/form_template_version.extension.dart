import 'package:built_collection/built_collection.dart';
import 'package:datarunmobile/database/app_database.dart';
import 'package:datarunmobile/database/shared/form_option.dart';
import 'package:datarunmobile/database/shared/form_template_model.dart';

extension FormTemplateVersionModel on FormTemplateVersion {
  /// This version as a form model, enough to walk its fields and sections.
  /// The form's name, labels and option sets are not loaded.
  FormTemplateModel toTemplateModel() => FormTemplateModel(
        id: template,
        name: template,
        versionUid: id,
        versionNumber: versionNumber,
        fields: BuiltList(fields),
        sections: BuiltList(sections),
        options: BuiltList<FormOption>(options ?? const []),
      );
}
