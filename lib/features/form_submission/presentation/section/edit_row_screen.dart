import 'package:d_sdk/core/code_generator.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/edit_row_panel.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_metadata_inherit_widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditRowScreen extends ConsumerStatefulWidget {
  EditRowScreen(
      {required this.repeatInstance,
      required this.item,
      this.title,
      this.onRemoveItem,
      required this.onSave});

  final String? title;

  final void Function(FormGroup form, EditActionType action) onSave;

  final RepeatItemInstance item;

  final RepeatSection repeatInstance;

  final void Function(RepeatItemInstance item)? onRemoveItem;

  @override
  EditRowScreenState createState() => EditRowScreenState();
}

class EditRowScreenState extends ConsumerState<EditRowScreen> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formGroup = ReactiveForm.of(context);
    // final FormInstance formInstance = ref
    //     .watch(formInstanceProvider(submissionId: widget.submissionId))
    //     .requireValue;
    final formInstance = appLocator<FormInstance>();

    if (formGroup is! FormGroup) {
      throw FormControlParentNotFoundException(widget);
    }

    List<Widget> buildSlivers() {
      return widget.item.elements.values.map((element) {
        if (element is Section) {
          return SectionWidget(
            // key: key,
            element: element,
          );
        } else if (element is RepeatSection) {
          return RepeatTableSliver(
            // key: key,
            repeatInstance: element,
          );
        } else if (element is FieldInstance) {
          return FieldWidget(
              key: appLocator<FieldContextRegistry>()
                  .getOrCreateKey(element.elementPath!),
              element: element);
        }
        return const SliverToBoxAdapter();
      }).toList();
    }

    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? S.of(context).edit),
      ),
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, result) async {
            if (didPop) {
              return;
            }

            final bool shouldPop = await _onTryToClose(
              context,
              formInstance,
              widget.repeatInstance,
              widget.item,
            );
            if (context.mounted && shouldPop) {
              Navigator.pop(context);
            }
          },
          child: FormMetadataWidget(
            formMetadata: formInstance.formMetadata,
            child: ReactiveForm(
              formGroup: widget.item.elementControl,
              child: CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: buildSlivers(),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: formGroup.valid
          ? Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  FloatingActionButton(
                    backgroundColor: cs.primary,
                    heroTag: 'saveAndClose',
                    onPressed: () async {
                      widget.onSave(formGroup, EditActionType.SAVE_AND_CLOSE);
                    },
                    child: Icon(MdiIcons.contentSaveCheck),
                    tooltip: S.of(context).saveAndClose,
                  ),
                  FloatingActionButton(
                    backgroundColor: cs.secondary,
                    onPressed: () async {
                      widget.onSave(
                          formGroup, EditActionType.SAVE_AND_ADD_ANOTHER);
                    },
                    heroTag: 'addNew',
                    child: Icon(MdiIcons.plus),
                    tooltip: S.of(context).addNew,
                  ),
                ],
              ),
            )
          : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<bool> _onTryToClose(BuildContext context, FormInstance formInstance,
      RepeatSection repeatInstance, RepeatItemInstance repeatItem) async {
    final isNew = repeatItem.uid == null;

    if (/*control.itemFormGroup.dirty && */ isNew) {
      final bool? confirmClose = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          final cs = Theme.of(context).colorScheme;
          return AlertDialog(
            title: Text(S.of(context).unsavedChangesWarning),
            content: Text(S.of(context).closeWithoutSaving),
            actions: <Widget>[
              if (repeatItem.elementControl.valid)
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  child: Text(S.of(context).saveAndClose),
                  onPressed: () {
                    repeatItem.setUid(CodeGenerator.generateUid());
                    Navigator.of(context).pop(true);
                  },
                ),
              // TextButton(
              //   child: Text(S.of(context).cancel),
              //   onPressed: () => Navigator.of(context).pop(false),
              // ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: cs.error,
                  foregroundColor: cs.onError,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                // icon: Icon(Icons.warning),
                label: Text(S.of(context).delete),
                onPressed: () {
                  final RepeatItemInstance? item =
                      formInstance.onRemoveLastItem(repeatInstance);
                  if (item != null) {
                    widget.onRemoveItem?.call(item);
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
