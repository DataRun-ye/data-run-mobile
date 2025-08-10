import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/features/data_instance/application/models.dart';
import 'package:datarunmobile/features/data_instance/presentation/cell_widgets/table_header_label.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A ConsumerStatefulWidget holds the DataTableSource
mixin TableColumnsBuildExtension {
  List<DataColumn> buildColumns(FormTemplateModel templateModel, WidgetRef ref,
      TableAppearance appAppearance) {
    return [
      _getStatusColumn(ref, appAppearance),
      _getEditColumn(ref, appAppearance),
      ..._getDynamicFormFields(templateModel, ref, appAppearance),
      ..._getDatesColumn(ref, appAppearance),
    ];
  }

  List<DataColumn> _getDynamicFormFields(FormTemplateModel templateModel,
      WidgetRef ref, TableAppearance appAppearance) {
    return templateModel.fields
        .where((f) => f.mainField)
        .map(
          (f) => DataColumn2(
              tooltip:
                  getItemLocalString(f.label.unlock, defaultString: f.name),
              label: TableHeaderLabel(
                  label: getItemLocalString(f.label.unlock,
                      defaultString: f.name)),
              numeric: f.type?.isNumeric == true,
              size: appAppearance.compact ? ColumnSize.S : ColumnSize.M),
        )
        .toList();
  }

  DataColumn _getStatusColumn(WidgetRef ref, TableAppearance appAppearance) {
    return DataColumn2(
      tooltip: S.current.status,
      label: TableHeaderLabel(label: S.current.status),
      // onSort: (i, asc) =>
      //     ref.read(tablePaginationProvider.notifier).sort('syncStatus', i, asc),
      size: ColumnSize.S,
      fixedWidth: appAppearance.compact || appAppearance.fixedActionColumns ? 35 : 50,
    );
  }

  DataColumn _getEditColumn(WidgetRef ref, TableAppearance appAppearance) {
    return DataColumn2(
      tooltip: S.current.editView,
      label: TableHeaderLabel(label: S.current.editView),
      size: ColumnSize.S,
      fixedWidth: appAppearance.compact || appAppearance.fixedActionColumns ? 50 : 70,
    );
  }

  List<DataColumn> _getDatesColumn(
      WidgetRef ref, TableAppearance appAppearance) {
    return [
      DataColumn2(
        tooltip: S.current.created,
        label: TableHeaderLabel(label: S.current.created),
        // onSort: (i, asc) => ref
        //     .read(tablePaginationProvider.notifier)
        //     .sort('createdDate', i, asc),
        size: appAppearance.compact ? ColumnSize.M : ColumnSize.S,
      ),
      DataColumn2(
        tooltip: S.current.modified,
        label: TableHeaderLabel(label: S.current.modified),
        // onSort: (i, asc) => ref
        //     .read(tablePaginationProvider.notifier)
        //     .sort('lastModifiedDate', i, asc),
        size: appAppearance.compact ? ColumnSize.M : ColumnSize.S,
      ),
    ];
  }
}
