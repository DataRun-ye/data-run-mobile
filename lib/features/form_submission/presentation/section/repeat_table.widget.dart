import 'package:datarunmobile/core/form/element_template/field_template.entity.dart';
import 'package:datarunmobile/core/form/element_template/get_item_local_string.dart';
import 'package:datarunmobile/core/common/confirmation_service.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/commons/errors_management/d_exception_reporter.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/repeat_row_edit_session.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_screen.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_rows_source.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_row_edit_result.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_row_edit_session_scope.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RepeatTable extends StatefulHookConsumerWidget {
  const RepeatTable({
    super.key,
    required this.repeatInstance,
    // this.onEdit,
    // this.onDelete,
    // this.onAdd,
  });

  final RepeatSection repeatInstance;

  // final void Function(int index)? onEdit;
  // final void Function(int index)? onDelete;
  // final void Function()? onAdd;

  @override
  RepeatTableState createState() => RepeatTableState();
}

class RepeatTableState extends ConsumerState<RepeatTable> {
  final _tableKey = GlobalKey<PaginatedDataTableState>();
  late final RepeatTableDataSource _dataSource;
  late final RepeatSection _repeatInstance;

  int defaultRowsPerPage = 5;
  int _firstRowIndex = 0;
  int _rowsPerPage = 5;

  Future<void> onEdit(RepeatItemInstance itemInstance) async {
    final formInstance = appLocator<FormInstance>();

    await _showEditPanel(
      context,
      formInstance,
      itemInstance,
      isNew: false,
    );
  }

  Future<void> onDelete(RepeatItemInstance item) {
    return _confirmAndDelete([item]);
  }

  Future<void> _confirmAndDelete(List<RepeatItemInstance> items) async {
    if (items.isEmpty || !mounted) {
      return;
    }

    final confirmedItems = List<RepeatItemInstance>.of(items);
    await withConfirmation(
      context: context,
      title: S.of(context).confirm,
      body: S.of(context).confirmDeleteItemsSelected(confirmedItems.length),
      confirmLabel: S.of(context).delete,
      onConfirmed: () {
        final formInstance = appLocator<FormInstance>();
        formInstance.removeRepeatedItems(confirmedItems, _repeatInstance);
        _dataSource.replaceItems(_repeatInstance.elements);
        _moveToLastAvailablePage();
        _repeatInstance.elementControl.markAsTouched();
      },
    );
  }

  void _moveToLastAvailablePage() {
    final rowCount = _dataSource.rowCount;
    final lastPageStart =
        rowCount == 0 ? 0 : ((rowCount - 1) ~/ _rowsPerPage) * _rowsPerPage;
    if (_firstRowIndex <= lastPageStart) {
      return;
    }
    _firstRowIndex = lastPageStart;
    _tableKey.currentState?.pageTo(lastPageStart);
  }

  @override
  void initState() {
    super.initState();
    _repeatInstance = widget.repeatInstance;
    _dataSource = RepeatTableDataSource(
      elements: widget.repeatInstance.elements,
      referenceAssignmentUid:
          appLocator<FormInstance>().formMetadata.assignmentId,
      onEdit: onEdit,
      onDelete: onDelete,
      onSelectionChanged: () {
        if (mounted) {
          setState(() {});
        }
      },
      editable: widget.repeatInstance.elementControl.enabled,
    );
  }

  @override
  void dispose() {
    _dataSource.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.repeatInstance.hidden) {
      widget.repeatInstance.elementControl.markAsDisabled(emitEvent: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formInstance = appLocator<FormInstance>();

    final List<FieldTemplate> tableColumns = useMemoized(() {
      return formInstance.formFlatTemplate
          .getChildrenOfType<FieldTemplate>(_repeatInstance.template.path)
        ..sort((a, b) => a.order.compareTo(b.order));
    }, [_repeatInstance.elementPath]);

    final rowsPerPage = useState(defaultRowsPerPage);

    return Opacity(
      opacity: _dataSource.editable ? 1 : 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PaginatedDataTable(
          key: _tableKey,
          primary: true,
          showFirstLastButtons: true,
          onPageChanged: (firstRowIndex) {
            _firstRowIndex = firstRowIndex;
          },
          onSelectAll: _dataSource.editable
              ? (selected) => _dataSource.setSelectedRange(
                    _firstRowIndex,
                    rowsPerPage.value,
                    selected ?? false,
                  )
              : null,
          actions: [
            if (_dataSource.editable && _dataSource.selectedRowCount > 0)
              IconButton(
                tooltip:
                    S.of(context).deleteSelected(_dataSource.selectedRowCount),
                onPressed: () => _confirmAndDelete(_dataSource.selectedItems),
                icon: const Icon(Icons.delete_sweep, color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _dataSource.editable
                  ? () async {
                      final formWasDirty = formInstance.form.dirty;
                      final formWasTouched = formInstance.form.touched;
                      final repeatItem =
                          formInstance.onAddRepeatedItem(_repeatInstance);
                      _dataSource.replaceItems(_repeatInstance.elements);

                      await _showEditPanel(
                        context,
                        formInstance,
                        repeatItem,
                        isNew: true,
                        formWasDirtyBeforeEdit: formWasDirty,
                        formWasTouchedBeforeEdit: formWasTouched,
                      );
                    }
                  : null,
              child: const Icon(Icons.add),
            ),
          ],
          header: Text(
            '${_repeatInstance.label}',
            softWrap: true,
          ),
          rowsPerPage: rowsPerPage.value,
          availableRowsPerPage: <int>[
            defaultRowsPerPage,
            defaultRowsPerPage * 2,
            defaultRowsPerPage * 5,
            defaultRowsPerPage * 10
          ],
          onRowsPerPageChanged: (rows) {
            if (rows != null) {
              _rowsPerPage = rows;
              rowsPerPage.value = rows;
            }
          },
          columns: _buildColumns(tableColumns, context,
              editMode: _dataSource.editable),
          source: _dataSource,
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns(
      List<FieldTemplate> tableColumns, BuildContext context,
      {bool editMode = true}) {
    return [
      const DataColumn(label: Text('#')),
      ...tableColumns
          .asMap()
          .entries
          .map((e) => DataColumn(
              label: Text(
                  '${getItemLocalString(e.value.label.unlock, defaultString: e.value.name)}'),
              numeric: e.value.type.isNumeric))
          .toList(),
      if (editMode)
        DataColumn(
            label: Text(
          S.of(context).edit,
          softWrap: true,
        )),
      if (editMode)
        DataColumn(
            label: Text(
          S.of(context).delete,
          softWrap: true,
        )),
    ];
  }

  Future<void> _showEditPanel(
    BuildContext context,
    FormInstance formInstance,
    RepeatItemInstance repeatItem, {
    required bool isNew,
    bool? formWasDirtyBeforeEdit,
    bool? formWasTouchedBeforeEdit,
  }) async {
    var currentItem = repeatItem;
    var currentIsNew = isNew;
    var wasDirtyBeforeEdit = formWasDirtyBeforeEdit;
    var wasTouchedBeforeEdit = formWasTouchedBeforeEdit;

    while (context.mounted) {
      final action = await _editRow(
        context,
        formInstance,
        currentItem,
        isNew: currentIsNew,
        formWasDirtyBeforeEdit: wasDirtyBeforeEdit,
        formWasTouchedBeforeEdit: wasTouchedBeforeEdit,
      );
      if (action != RepeatRowEditResult.savedAndAddAnother ||
          !context.mounted) {
        return;
      }

      wasDirtyBeforeEdit = formInstance.form.dirty;
      wasTouchedBeforeEdit = formInstance.form.touched;
      currentItem = formInstance.onAddRepeatedItem(_repeatInstance);
      currentIsNew = true;
      _dataSource.replaceItems(_repeatInstance.elements);
    }
  }

  Future<RepeatRowEditResult?> _editRow(
    BuildContext context,
    FormInstance formInstance,
    RepeatItemInstance repeatItem, {
    required bool isNew,
    bool? formWasDirtyBeforeEdit,
    bool? formWasTouchedBeforeEdit,
  }) async {
    final enclosingSession = RepeatRowEditSessionScope.maybeOf(context);
    formInstance.materializeRepeatItem(repeatItem);
    final session = RepeatRowEditSession(
      formInstance: formInstance,
      parent: _repeatInstance,
      item: repeatItem,
      isNew: isNew,
      formWasDirtyBeforeEdit: formWasDirtyBeforeEdit,
      formWasTouchedBeforeEdit: formWasTouchedBeforeEdit,
    );
    RepeatRowEditResult? action;
    final navigator = Navigator.of(context);
    final route = MaterialPageRoute<RepeatRowEditResult>(
      builder: (_) => FormMetadataWidget(
        formMetadata: formInstance.formMetadata,
        child: ReactiveForm(
          formGroup: repeatItem.elementControl,
          child: Builder(builder: (context) {
            final title =
                '${S.of(context).editItem}: ${_repeatInstance.template.itemTitle ?? _repeatInstance.label}';

            return EditRowScreen(
              title: title,
              item: repeatItem,
              session: session,
              onSave: () async {
                await session.save(
                  enclosingSession: enclosingSession,
                );
                _dataSource.replaceItems(_repeatInstance.elements);
              },
              onSaveError: (error, stackTrace) {
                DExceptionReporter.instance.report(
                  error,
                  stackTrace: stackTrace,
                  showToUser: true,
                );
              },
            );
          }),
        ),
      ),
    );
    try {
      action = await navigator.push(route);
      await route.completed;
    } finally {
      if (action == RepeatRowEditResult.discarded) {
        session.discard();
      } else {
        formInstance.dematerializeRepeatItem(repeatItem);
      }
      _dataSource.replaceItems(_repeatInstance.elements);
    }
    return action;
  }
}
