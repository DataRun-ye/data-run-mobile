import 'package:d_sdk/core/form/element_template/get_item_local_string.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:datarunmobile/features/data_instance/presentation/cell_widgets/table_header_label.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A ConsumerStatefulWidget holds the DataTableSource
mixin TableColumnsBuildExtension {
  List<DataColumn> buildColumns(
      FormTemplateModel templateModel, WidgetRef ref) {
    return [
      _getStatusColumn(ref),
      _getEditColumn(ref),
      ..._getDynamicFormFields(templateModel, ref),
      ..._getDatesColumn(ref),
    ];
  }

  List<DataColumn> _getDynamicFormFields(
      FormTemplateModel templateModel, WidgetRef ref) {
    return templateModel.fields
        .where((f) => f.mainField)
        .map(
          (f) => DataColumn2(
              label: TableHeaderLabel(
                  label: getItemLocalString(f.label.unlock,
                      defaultString: f.name)),
              numeric: f.type?.isNumeric == true,
              size: ColumnSize.M),
        )
        .toList();
  }

  DataColumn _getStatusColumn(WidgetRef ref) {
    return DataColumn2(
      label: TableHeaderLabel(label: S.current.status),
      // onSort: (i, asc) =>
      //     ref.read(tablePaginationProvider.notifier).sort('syncStatus', i, asc),
      size: ColumnSize.S,
      fixedWidth: 70,
    );
  }

  DataColumn _getEditColumn(WidgetRef ref) {
    return DataColumn2(
      label: TableHeaderLabel(label: S.current.editView),
      size: ColumnSize.S,
      fixedWidth: 80,
    );
  }

  List<DataColumn> _getDatesColumn(WidgetRef ref) {
    return [
      DataColumn2(
        label: TableHeaderLabel(label: S.current.created),
        // onSort: (i, asc) => ref
        //     .read(tablePaginationProvider.notifier)
        //     .sort('createdDate', i, asc),
        size: ColumnSize.M,
      ),
      DataColumn2(
        label: TableHeaderLabel(label: S.current.modified),
        // onSort: (i, asc) => ref
        //     .read(tablePaginationProvider.notifier)
        //     .sort('lastModifiedDate', i, asc),
        size: ColumnSize.M,
      ),
    ];
  }
}
