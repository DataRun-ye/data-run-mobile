import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/base_dao_extension.dart';
import 'package:d_sdk/database/shared/form_template_model.dart';
import 'package:d_sdk/database/tables/tables.dart';
import 'package:drift/drift.dart';

part 'form_template_versions_dao.g.dart';

@DriftAccessor(tables: [FormTemplateVersions])
class FormTemplateVersionsDao extends DatabaseAccessor<AppDatabase>
    with _$FormTemplateVersionsDaoMixin, BaseDaoMixin<FormTemplateVersion> {
  FormTemplateVersionsDao(AppDatabase db) : super(db);

  @override
  String get resourceName => 'formTemplateVersions';

  @override
  FormTemplateVersion fromApiJson(Map<String, dynamic> data,
      {ValueSerializer? serializer}) {
    return FormTemplateVersion.fromJson({
      ...data,
      'template': data['templateUid'],
    }, serializer: serializer);
  }

  @override
  $FormTemplateVersionsTable get table => formTemplateVersions;

  Selectable<FormTemplateModel> selectFormTemplatesWithRefs({
    String? assignmentId,
    String? versionId,
  }) {
    // Aliases
    final ftv = alias(formTemplateVersions, 'ftv');
    final af  = alias(attachedDatabase.assignmentForms, 'a');

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
          ftv.template.equalsExp(formTemplates.id) &
          ftv.id.equals(versionId),
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

    return query
        .map((row) {
      final tmpl = row.readTable(formTemplates);
      final ver  = row.readTable(ftv);
      return (tmpl, ver);
    })
        .map((tuple) {
      final (t, v) = tuple;
      return FormTemplateModel(
        id:            t.id,
        name:          t.name,
        versionUid:    v.id,
        label:         t.label,
        description:   t.description,
        versionNumber: v.versionNumber,
        fields:        v.fields.build(),
        sections:      v.sections.build(),
      );
    });
  }

// Selectable<FormTemplateModel> selectFormTemplatesWithRefs(
  //     {String? assignmentId, String? versionId}) {
  //   // Alias the version table for the aggregation subquery
  //   final latestVersionsNumbers = alias(formTemplateVersions, 'lv_nums');
  //
  //   // Build a select-only query to get max(versionNumber) per template
  //   final versionMaxQuery = selectOnly(latestVersionsNumbers)
  //     ..addColumns([
  //       latestVersionsNumbers.template, // template FK
  //       latestVersionsNumbers.versionNumber.max(), // max versionNumber
  //     ])
  //     ..groupBy([
  //       latestVersionsNumbers.template
  //     ]); // group by template FK :contentReference[oaicite:4]{index=4}
  //
  //   // Wrap it as a subquery named 'lv'
  //   final latestVersionsSub = Subquery(versionMaxQuery, 'lv');
  //
  //   // Alias the version table again to join for details
  //   final ftv = alias(formTemplateVersions, 'ftv');
  //   final af = alias(attachedDatabase.assignmentForms, 'a');
  //
  //   // Perform the join: FormTemplate ↔ detailed version ↔ max-version subquery
  //   final query = select(formTemplates).join([
  //     innerJoin(
  //       ftv,
  //       ftv.template.equalsExp(formTemplates.id) // match on template ID
  //           &
  //           ftv.versionNumber.equalsExp(latestVersionsSub
  //               .ref(latestVersionsNumbers.versionNumber.max())),
  //     ),
  //     innerJoin(formTemplates, af.form.equalsExp(formTemplates.id),
  //         useColumns: false),
  //   ]);
  //
  //   if (assignmentId != null) {
  //     query.where(af.assignment.equals(assignmentId));
  //   }
  //
  //   return query.map((row) {
  //     final tmpl = row.readTable(formTemplates);
  //     final ver = row.readTable(ftv);
  //     return (tmpl, ver);
  //   }).map((withRef) {
  //     final (t, v) = withRef;
  //
  //     return FormTemplateModel(
  //       id: t.id,
  //       name: t.name,
  //       versionUid: v.id,
  //       label: t.label,
  //       description: t.description,
  //       versionNumber: v.versionNumber,
  //       fields: v.fields.build(),
  //       sections: v.sections.build(),
  //     );
  //   });
  // }

// Future<List<(FormTemplate, FormTemplateVersion)>>
//     selectFormTemplatesWithRefs() async {
//   final latestVersions = Subquery(
//     select(formTemplateVersions)
//       ..orderBy([(row) => OrderingTerm.desc(row.versionNumber)])
//       ..limit(1),
//     's',
//   );
//
//   final query = select(formTemplates).join(
//     [
//       innerJoin(
//           latestVersions,
//           // Again using .ref() here to access the category in the outer select
//           // statement.
//           latestVersions
//               .ref(formTemplateVersions.template)
//               .equalsExp(formTemplates.id))
//     ],
//   )..groupBy([formTemplates.id]);
//
//   final rows = await query.get();
//
//   return [
//     for (final row in rows)
//       (row.readTable(formTemplates), row.readTable(latestVersions)!),
//   ];
// }
}
