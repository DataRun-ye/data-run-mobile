import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'form_template_versions_dao.g.dart';

@DriftAccessor(tables: [FormTemplateVersions])
class FormTemplateVersionsDao extends DatabaseAccessor<AppDatabase>
    with _$FormTemplateVersionsDaoMixin {
  FormTemplateVersionsDao(AppDatabase db) : super(db);

  Selectable<FormTemplateModel> selectFormTemplatesWithRefs({
    String? assignmentId,
    String? versionId,
  }) {
    // Aliases
    final ftv = alias(formTemplateVersions, 'ftv');
    final af = alias(attachedDatabase.assignmentForms, 'a');

    // Build subquery for (template, maxVersionNumber)
    final lvNums = alias(formTemplateVersions, 'lv_nums');
    final versionMaxQuery = selectOnly(lvNums)
      ..addColumns([
        lvNums.template,
        lvNums.versionNumber.max(),
      ])
      ..groupBy([lvNums.template]);
    final latestSub = Subquery(versionMaxQuery, 'lv');

    // Collect joins
    final joins = <Join>[
      // 1) join to either “latest” or “specific” version:
      if (versionId == null) ...[
        innerJoin(
          ftv,
          ftv.template.equalsExp(formTemplates.id) &
              ftv.versionNumber.equalsExp(
                latestSub.ref(lvNums.versionNumber.max()),
              ),
        ),
      ] else ...[
        innerJoin(
          ftv,
          ftv.template.equalsExp(formTemplates.id) & ftv.id.equals(versionId),
        ),
      ],

      // 2) join AssignmentForms if needed
      innerJoin(
        af,
        af.form.equalsExp(formTemplates.id),
        useColumns: false,
      ),
    ];

    // Base query
    final query = select(formTemplates).join(joins);

    // Optional assignment‐filter
    if (assignmentId != null) {
      query.where(af.assignment.equals(assignmentId));
    }

    return query.map((row) {
      final tmpl = row.readTable(formTemplates);
      final ver = row.readTable(ftv);
      return (tmpl, ver);
    }).map((tuple) {
      final (t, v) = tuple;
      return FormTemplateModel(
        id: t.id,
        disabled: t.disabled ?? false,
        name: t.name,
        versionUid: v.id,
        label: t.label,
        description: t.description,
        versionNumber: v.versionNumber,
        fields: v.fields.build(),
        sections: v.sections.build(),
        options: (v.options ?? []).build(),
      );
    });
  }
}
