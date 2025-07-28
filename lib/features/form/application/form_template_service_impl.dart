import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form/application/form_list_item_model.dart';
import 'package:datarunmobile/features/form/application/form_template_service.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FormTemplateService)
class FormTemplateServiceImpl extends FormTemplateService {
  final AppDatabase _db = appLocator<DbManager>().db;

  @override
  Future<List<FormListItemModel>> fetchByAssignment(String assignmentId) {
    final result = _db.managers.formTemplates
        .filter((f) => f.assignments(
            (f) => f.assignment.id(assignmentId) & f.canViewSubmissions(true)))
        .asyncMap((f) async => FormListItemModel(
            id: f.id,
            name: f.name,
            versionNumber: f.versionNumber,
            syncStatuses: await _db.dataInstancesDao
                .selectStatusByLevel(
                    id: f.id, aggregationLevel: StatusAggregationLevel.form)
                .get(),
            versionUid: f.versionUid))
        .get();
    return result;
  }

  Future<bool> canAddSubmissions(String formTemplateId) async {
    final canAddForms = await _db.managers.formTemplates
        .filter((f) =>
            f.id(formTemplateId) &
            f.assignments((a) => a.canAddSubmissions(true)))
        .get();
    return canAddForms.isNotEmpty;
  }
}
