import 'package:d_sdk/database/app_database.dart';
import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';

class FormStructureManager {
  FormStructureManager(
      {Map<String, dynamic> formValueMap = const {},
      required this.formVersion,
      required this.formFlatTemplate}) {
    _formValueMapBackup.addAll({...formValueMap});
    _formValueMap.addAll({...formValueMap});
  }
  final Map<String, dynamic> _formValueMapBackup = {};
  final Map<String, dynamic> _formValueMap = {};
  final FormTemplateVersion formVersion;
  final FormTemplateRepository formFlatTemplate;

  void resetForm() {
    _formValueMap.clear();
    _formValueMap.addAll(_formValueMapBackup);
  }

  void setFormValue(String elementId, dynamic value) {
    _formValueMap[elementId] = value;
  }

// bool isFormValid() {
//   for (final FormElementTemplate elementTemplate in formFlatTemplate.elements) {
//     final FormElementModel elementModel = FormElementModel(elementTemplate);
//     if (!elementModel.isValid(_formValueMap[elementTemplate.id])) {
//       return false;
//     }
//   }
//   return true;
// }
}
