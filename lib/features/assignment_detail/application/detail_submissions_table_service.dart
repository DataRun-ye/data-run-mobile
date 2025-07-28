import 'package:datarunmobile/data/form_template_repository.dart';

class DetailSubmissionsTableService {
  DetailSubmissionsTableService({required FormTemplateRepository formTemplateRepository}) : _formTemplateRepository = formTemplateRepository;

  final FormTemplateRepository _formTemplateRepository;
}
