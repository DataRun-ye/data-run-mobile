import 'package:built_collection/built_collection.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/dao/data_submissions_dao.dart';
import 'package:d_sdk/database/shared/shared.dart';

extension DataInstancesDaoExpressionExtension on DataInstancesDao {
  Future<FormTemplateModel> getTemplateByVersionOrLatest(
      {String? templateId, String? versionId}) async {
    assert(templateId != null || versionId != null);
    var query = attachedDatabase.managers.formTemplateVersions
        .withReferences((prefetch) => prefetch(template: true));

    if (versionId != null) {
      query = query.filter((f) => f.id(versionId));
    } else {
      query = query.filter((f) => f.template.id(templateId));
    }

    final List<(FormTemplateVersion, $$FormTemplateVersionsTableReferences)>
        formTemplateWithRefs =
        await query.orderBy((o) => o.versionNumber.desc()).limit(1).get();
    final (templateVersion, refs) = formTemplateWithRefs.first;

    final formTemplate = refs.template.prefetchedData!.first;

    return FormTemplateModel(
      id: formTemplate.id,
      name: formTemplate.name,
      versionUid: templateVersion.id,
      label: formTemplate.label,
      description: formTemplate.description,
      versionNumber: templateVersion.versionNumber,
      fields: templateVersion.fields.build(),
      sections: templateVersion.sections.build(),
    );
  }

  // // Helper method to calculate the date range based on the enum
  // (DateTime, DateTime) getDateRangeFromBand(DateFilterBand band) {
  //   final now = DateTime.now();
  //   DateTime startDate;
  //   DateTime endDate;
  //
  //   // Set the time of day to midnight for consistent date filtering
  //   final today = DateTime(now.year, now.month, now.day);
  //
  //   switch (band) {
  //     case DateFilterBand.today:
  //       startDate = today;
  //       endDate = today.add(const Duration(days: 1));
  //       break;
  //     case DateFilterBand.lastThreeDays:
  //       startDate = today.subtract(const Duration(days: 2));
  //       endDate = today.add(const Duration(days: 1));
  //       break;
  //     case DateFilterBand.thisWeek:
  //       // Find the start of the week (e.g., Monday)
  //       final weekday = now.weekday == 0 ? 7 : now.weekday;
  //       startDate = today.subtract(Duration(days: weekday - 1));
  //       endDate = startDate.add(const Duration(days: 7));
  //       break;
  //     case DateFilterBand.thisMonth:
  //       startDate = DateTime(now.year, now.month, 1);
  //       endDate = DateTime(now.year, now.month + 1, 1);
  //       break;
  //     case DateFilterBand.lastThreeMonths:
  //       startDate = DateTime(now.year, now.month - 2, 1);
  //       endDate = DateTime(now.year, now.month + 1, 1);
  //       break;
  //     case DateFilterBand.thisYear:
  //       startDate = DateTime(now.year, 1, 1);
  //       endDate = DateTime(now.year + 1, 1, 1);
  //       break;
  //     // // case DateFilterBand.allDates:
  //     // // default:
  //     //   // No filter, return a wide date range
  //     //   startDate = DateTime(2000); // A very old date
  //     //   endDate = DateTime.now().add(const Duration(days: 365));
  //     //   break;
  //   }
  //
  //   return (startDate, endDate);
  // }
}
