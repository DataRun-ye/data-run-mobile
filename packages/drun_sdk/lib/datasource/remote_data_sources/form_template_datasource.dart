import 'package:d_sdk/core/user_session/user_session.dart';
import 'package:d_sdk/database/converters/converters.dart';
import 'package:d_sdk/database/database.dart';
import 'package:d_sdk/datasource/datasource.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@Order(DSOrder.formTemplate)
@Injectable(as: AbstractDatasource, scope: UserSession.activeSessionScope)
class DataFormTemplateDatasource
    extends BaseDataSource<$FormTemplatesTable, FormTemplate>
    implements MetaDataSource<FormTemplate> {
  @override
  String get resourceName => 'formTemplates';

  /// fetch versions async and emit as CompanionInsert
  @override
  Future<List<CompanionInsert>> extractExtraEntities(
      List<Map<String, dynamic>> raw) async {
    final items = await _getFormVersions();
    return items
        .map((v) => CompanionInsert(db.formTemplateVersions, v))
        .toList();
  }

  @override
  FormTemplate mapRemoteItem(Map<String, dynamic> json) {
    final base = super.mapRemoteItem(json);
    final bool disabled = json['disabled'] == true;
    return base.copyWith(
      disabled: Value(disabled),
    );
  }

  Future<List<FormTemplateVersion>> _getFormVersions() async {
    final formVersionResourceName = 'formTemplateVersions';

    final resourcePath = '$formVersionResourceName?paged=false';
    final response =
        await apiClient.request(resourceName: resourcePath, method: 'get');

    final raw = response.data;

    List dataItems = raw?[formVersionResourceName]?.toList() ?? [];

    return dataItems.map((item) {
      return FormTemplateVersion.fromJson({
        ...item,
        'id': item['uid']!,
        'template': item['templateUid']!,
      }, serializer: CustomSerializer());
    }).toList();
  }

  @override
  Future<void> disableStale(List<Object> liveIds) async {
    await (db.update(table)
          ..where((t) => t.columnsByName['id']!.isNotIn(liveIds)))
        .write(RawValuesInsertable({
      'disabled': Variable<bool>(true),
    }));
  }

  @override
  FormTemplate fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    final bool disabled = data['disabled'] == true;
    return FormTemplate.fromJson({
      ...data,
      'disabled': disabled,
    }, serializer: serializer);
  }

  @override
  $FormTemplatesTable get table => db.formTemplates;
}
