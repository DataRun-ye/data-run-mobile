import 'package:d_sdk/core/form/element_template/element_template.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/data/code_generator.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_panel.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_screen.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_rows_source.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked_services/stacked_services.dart';

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
  late final RepeatTableDataSource _dataSource;
  late final RepeatSection _repeatInstance;

  int defaultRowsPerPage = 5;

  Future<void> onEdit(int index) async {
    final formInstance = ref
        .read(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    final itemInstance = _dataSource.elements[index];
    await _showEditPanel(context, formInstance, itemInstance);
  }

  void onDelete(int index) {
    final formInstance = ref
        .read(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;
    final removed = formInstance.onRemoveRepeatedItem(index, _repeatInstance);
    _dataSource.removeItem(removed);
    _repeatInstance.elementControl.markAsTouched();
  }

  @override
  void initState() {
    super.initState();
    _repeatInstance = widget.repeatInstance;
    _dataSource = RepeatTableDataSource(
      elements: widget.repeatInstance.elements,
      onEdit: (value) => onEdit(value),
      onDelete: onDelete,
      editable: widget.repeatInstance.elementControl.enabled,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.repeatInstance.hidden) {
      widget.repeatInstance.elementControl.markAsDisabled(emitEvent: false);
    }
    if (widget.repeatInstance.elements != _repeatInstance.elements) {
      _dataSource.updateItems(_repeatInstance.elements);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formInstance = ref
        .watch(
            formInstanceProvider(formMetadata: FormMetadataWidget.of(context)))
        .requireValue;

    final List<FieldTemplate> tableColumns = useMemoized(() {
      return formInstance.formFlatTemplate
          .getChildrenOfType<FieldTemplate>(_repeatInstance.elementPath!)
        ..sort((a, b) => a.order.compareTo(b.order));
    }, [_repeatInstance.elementPath]);

    final rowsPerPage = useState(defaultRowsPerPage);

    return Opacity(
      opacity: _dataSource.editable ? 1 : 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PaginatedDataTable(
          primary: true,
          showFirstLastButtons: true,
          actions: [
            ElevatedButton(
              onPressed: _dataSource.editable
                  ? () async {
                      final repeatItem =
                          formInstance.onAddRepeatedItem(_repeatInstance);
                      _dataSource.addItem(repeatItem);
                      await _showEditPanel(context, formInstance, repeatItem);
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

  Future<void> _showEditPanel(BuildContext context, FormInstance formInstance,
      [RepeatItemInstance? repeatItem]) async {
    if (true) {
      bool itemSaved = false;
      appLocator<NavigationService>().navigateToView(FormMetadataWidget(
          formMetadata: formInstance.formMetadata,
          child: ReactiveForm(
            formGroup: repeatItem!.elementControl,
            child: Builder(builder: (context) {
              String title =
                  '${S.of(context).editItem}: ${_repeatInstance.template.itemTitle ?? _repeatInstance.label}';


              return EditRowScreen(
                title: title,
                repeatInstance: _repeatInstance,
                item: repeatItem,
                onRemoveItem: (item) {
                  _dataSource.removeItem(item);
                },
                onSave: (formGroup, action) {
                  _repeatInstance.elementControl.markAsTouched();
                  formInstance.saveFormData();
                  _dataSource.updateItems(_repeatInstance.elements);
                  // repeatItem.updateValue(formGroup.value);
                  if (formGroup.valid) {
                    itemSaved = true;
                    _handleSave(context, formInstance, _repeatInstance,
                        repeatItem, action);
                  }
                },
              );
            }),
          )));
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //       builder: (context) => ),
      // );
    }
  }

  Future<void> showEditDialog(BuildContext context, FormInstance formInstance,
      [RepeatItemInstance? repeatItem]) async {
    bool itemSaved = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, result) async {
            if (didPop) {
              return;
            }

            final bool shouldPop = await _onTryToClose(
              context,
              formInstance,
              _repeatInstance,
              repeatItem!,
              itemSaved,
            );
            if (context.mounted && shouldPop) {
              Navigator.pop(context);
            }
          },
          child: FormMetadataWidget(
            formMetadata: formInstance.formMetadata,
            child: Builder(builder: (context) {
              String title = repeatItem == null
                  ? '${S.of(context).newItem}: ${_repeatInstance.template.itemTitle ?? _repeatInstance.label}'
                  : '${S.of(context).editItem}: ${_repeatInstance.template.itemTitle ?? _repeatInstance.label}';

              // if (repeatItem == null) {
              //   repeatItem = formInstance.onAddRepeatedItem(_repeatInstance);
              //   _dataSource.addItem(repeatItem!);
              // }

              return ReactiveForm(
                formGroup: repeatItem!.elementControl,
                child: Dialog(
                  child: EditRowPanel(
                    title: title,
                    repeatInstance: _repeatInstance,
                    item: repeatItem,
                    onSave: (formGroup, action) {
                      _repeatInstance.elementControl.markAsTouched();
                      formInstance.saveFormData();
                      _dataSource.updateItems(_repeatInstance.elements);
                      // repeatItem.updateValue(formGroup.value);
                      if (formGroup.valid) {
                        itemSaved = true;
                        _handleSave(context, formInstance, _repeatInstance,
                            repeatItem, action);
                      }
                    },
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future<void> _handleSave(
      BuildContext context,
      FormInstance formInstance,
      RepeatSection repeatInstance,
      RepeatItemInstance repeatItem,
      EditActionType action) async {
    if (repeatItem.elementControl.valid) {
      // the values are already updated, just to let the repeat
      // instance emit on stream so it rebuilds,
      Navigator.of(context).pop(); // Close the current dialog

      if (action == EditActionType.SAVE_AND_ADD_ANOTHER) {
        final repeatItem = formInstance.onAddRepeatedItem(_repeatInstance);
        _dataSource.addItem(repeatItem);
        _showEditPanel(context, formInstance, repeatItem);
      } else if (action == EditActionType.SAVE_AND_CLOSE) {
        // Do nothing, as we've already closed the dialog
      }
    }
  }

  Future<bool> _onTryToClose(
      BuildContext context,
      FormInstance formInstance,
      RepeatSection repeatInstance,
      RepeatItemInstance repeatItem,
      bool itemSaved) async {
    final isNew = repeatItem.uid == null;

    if (/*control.itemFormGroup.dirty && */ isNew) {
      final bool? confirmClose = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).unsavedChangesWarning),
            content: Text(S.of(context).closeWithoutSaving),
            actions: <Widget>[
              TextButton(
                child: Text(S.of(context).cancel),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              if (repeatItem.elementControl.valid)
                TextButton(
                  child: Text(S.of(context).saveAndClose),
                  onPressed: () {
                    repeatItem.setUid(CodeGenerator.generateUid());
                    Navigator.of(context).pop(true);
                  },
                ),
              TextButton(
                child: Text(S.of(context).closeWithoutSaving),
                onPressed: () {
                  final item = formInstance.onRemoveLastItem(repeatInstance);
                  if (item != null) {
                    _dataSource.removeItem(item);
                  }
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );

      return (confirmClose ?? false);
    } else if (repeatItem.elementControl.valid) {
      return true;
    }
    return false;
  }
}
