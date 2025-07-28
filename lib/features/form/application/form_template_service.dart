import 'package:datarunmobile/features/form/application/form_list_item_model.dart';

abstract class FormTemplateService {
  Future<List<FormListItemModel>> fetchByAssignment(String assignmentId);
}
