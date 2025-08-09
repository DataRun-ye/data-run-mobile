import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/converters/custom_serializer.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:d_sdk/datasource/base_datasource.dart';
import 'package:drift/drift.dart';

part 'form_templates_dao.g.dart';

@DriftAccessor(tables: [FormTemplates])
class FormTemplatesDao extends DatabaseAccessor<AppDatabase>
    with _$FormTemplatesDaoMixin, BaseDaoMixin<FormTemplate> {
  FormTemplatesDao(AppDatabase db) : super(db);

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
  $FormTemplatesTable get table => formTemplates;

  Selectable<FormTemplateModel> selectFormTemplatesWithRefs(
      {String? assignmentId}) {
    // Alias the version table for the aggregation subquery
    final latestVersionsNumbers =
        alias(attachedDatabase.formTemplateVersions, 'lv_nums');

    // Build a select-only query to get max(versionNumber) per template
    final versionMaxQuery = selectOnly(latestVersionsNumbers)
      ..addColumns([
        latestVersionsNumbers.template, // template FK
        latestVersionsNumbers.versionNumber.max(), // max versionNumber
      ])
      ..groupBy([
        latestVersionsNumbers.template
      ]); // group by template FK :contentReference[oaicite:4]{index=4}

    // Wrap it as a subquery named 'lv'
    final latestVersionsSub = Subquery(
        versionMaxQuery, 'lv'); // :contentReference[oaicite:5]{index=5}

    // Alias the version table again to join for details
    final ftv = alias(attachedDatabase.formTemplateVersions,
        'ftv'); // :contentReference[oaicite:6]{index=6}
    final af = alias(db.assignmentForms, 'a');

    // Perform the join: FormTemplate ↔ detailed version ↔ max-version subquery
    final query = select(formTemplates).join([
      innerJoin(
        ftv,
        ftv.template.equalsExp(formTemplates.id) // match on template ID
            &
            ftv.versionNumber.equalsExp(latestVersionsSub
                .ref(latestVersionsNumbers.versionNumber.max())),
      ),
      innerJoin(formTemplates, af.form.equalsExp(formTemplates.id),
          useColumns: false),
    ]);

    if (assignmentId != null) {
      query.where(af.assignment.equals(assignmentId));
    }

    // Execute and map results
    // final JoinedSelectStatement<HasResultSet, dynamic> rows = query;
    return query.map((row) {
      final tmpl = row.readTable(formTemplates);
      final ver = row.readTable(ftv);
      return (tmpl, ver);
    }).map((tuple) {
      final (t, v) = tuple;
      return FormTemplateModel(
        id: t.id,
        name: t.name,
        versionUid: v.id,
        label: t.label,
        description: t.description,
        versionNumber: v.versionNumber,
        fields: v.fields.build(),
        sections: v.sections.build(),
      );
    });
  }
}
