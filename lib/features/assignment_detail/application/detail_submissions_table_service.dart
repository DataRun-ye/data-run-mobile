import 'package:datarunmobile/data/form_template_version_tree_mixin.dart';

class DetailSubmissionsTableService {
  DetailSubmissionsTableService({required FormTemplateRepository formTemplateRepository}) : _formTemplateRepository = formTemplateRepository;

  final FormTemplateRepository _formTemplateRepository;
}
