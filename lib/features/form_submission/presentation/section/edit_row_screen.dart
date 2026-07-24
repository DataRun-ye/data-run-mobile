import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/field_context_registry.dart';
import 'package:datarunmobile/features/form_submission/application/repeat_row_edit_session.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_row_edit_result.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_row_edit_session_scope.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditRowScreen extends StatefulWidget {
  const EditRowScreen({
    super.key,
    required this.item,
    required this.session,
    this.title,
    required this.onSave,
    required this.onSaveError,
  });

  final String? title;

  final Future<void> Function() onSave;
  final void Function(Object error, StackTrace stackTrace) onSaveError;

  final RepeatItemInstance item;

  final RepeatRowEditSession session;

  @override
  State<EditRowScreen> createState() => _EditRowScreenState();
}

class _EditRowScreenState extends State<EditRowScreen> {
  bool _allowPop = false;
  bool _isClosing = false;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final formGroup = ReactiveForm.of(context);

    if (formGroup is! FormGroup) {
      throw FormControlParentNotFoundException(widget);
    }

    List<Widget> buildSlivers() {
      return widget.item.elements.values.map((element) {
        if (element is Section) {
          return SectionWidget(element: element);
        } else if (element is RepeatSection) {
          return RepeatTableSliver(
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
          canPop: _allowPop,
          onPopInvokedWithResult: (bool didPop, result) async {
            if (didPop || _isClosing || _isSaving) {
              return;
            }
            await _onTryToClose(context);
          },
          child: RepeatRowEditSessionScope(
            session: widget.session,
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: buildSlivers(),
            ),
          ),
        ),
      ),
      floatingActionButton: widget.session.canSave
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
                    heroTag: '${identityHashCode(widget.item)}_save',
                    onPressed: _isSaving
                        ? null
                        : () => _saveAndClose(RepeatRowEditResult.saved),
                    child: _isSaving
                        ? const SizedBox.square(
                            dimension: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    tooltip: S.of(context).saveAndClose,
                  ),
                  FloatingActionButton(
                    backgroundColor: cs.secondary,
                    onPressed: _isSaving
                        ? null
                        : () => _saveAndClose(
                              RepeatRowEditResult.savedAndAddAnother,
                            ),
                    heroTag: '${identityHashCode(widget.item)}_addNew',
                    child: const Icon(Icons.add),
                    tooltip: S.of(context).addNew,
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Future<void> _onTryToClose(BuildContext context) async {
    switch (widget.session.backAction) {
      case RepeatRowBackAction.close:
        _requestPop();
        return;
      case RepeatRowBackAction.discard:
        _requestPop(RepeatRowEditResult.discarded);
        return;
      case RepeatRowBackAction.confirm:
        final action = await _showCloseDecisionDialog(context);
        if (!mounted || action == null) {
          return;
        }
        if (action == RepeatRowEditResult.saved) {
          await _saveAndClose(action);
        } else if (action == RepeatRowEditResult.discarded) {
          _requestPop(action);
        }
    }
  }

  Future<RepeatRowEditResult?> _showCloseDecisionDialog(
    BuildContext context,
  ) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final route = DialogRoute<RepeatRowEditResult>(
      context: context,
      themes: InheritedTheme.capture(
        from: context,
        to: navigator.context,
      ),
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(dialogContext).unsavedChangesWarning),
        content: Text(S.of(dialogContext).closeWithoutSaving),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(dialogContext).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(
              dialogContext,
              RepeatRowEditResult.discarded,
            ),
            child: Text(S.of(dialogContext).discard),
          ),
          if (widget.session.canSave)
            FilledButton(
              onPressed: () => Navigator.pop(
                dialogContext,
                RepeatRowEditResult.saved,
              ),
              child: Text(S.of(dialogContext).saveAndClose),
            ),
        ],
      ),
    );
    final action = await navigator.push(route);
    await route.completed;
    return action;
  }

  Future<void> _saveAndClose(RepeatRowEditResult action) async {
    if (_isSaving || _isClosing || !widget.session.canSave) {
      return;
    }
    setState(() => _isSaving = true);
    try {
      await widget.onSave();
      if (mounted) {
        _requestPop(action);
      }
    } catch (error, stackTrace) {
      widget.onSaveError(error, stackTrace);
    } finally {
      if (mounted && !_isClosing) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _requestPop([RepeatRowEditResult? result]) {
    if (_isClosing) {
      return;
    }
    setState(() {
      _isClosing = true;
      _allowPop = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Navigator.of(context).pop(result);
      }
    });
  }
}
