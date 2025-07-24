import 'package:datarunmobile/features/form_submission/application/element/form_element.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_instance.dart';
import 'package:datarunmobile/features/form_submission/presentation/field/field.widget.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/repeat_table_sliver.dart';
import 'package:datarunmobile/features/form_submission/presentation/section/section.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// A reusable dialog that renders a sliver-based form (sections, repeats, fields)
/// with Cancel and Save actions.
class SliverFormDialog extends HookConsumerWidget {
  SliverFormDialog({
    Key? key,
    required this.formInstance,
    required this.onSave,
    required this.onCancel,
    this.maxHeight = 600,
  }) : super(key: key);

  /// The FormInstance providing form data, controls, and template.
  final FormInstance formInstance;

  /// Called when the user taps "Save".
  final VoidCallback onSave;

  /// Called when the user taps "Cancel" or closes the dialog.
  final VoidCallback onCancel;

  /// Maximum height of the dialog (adjust as needed).
  final double maxHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();

    List<Widget> buildSlivers() {
      return formInstance.formSection.elements.values.map((element) {
        // You can use SliverVisibility or filter out hidden elements here
        if (element is Section) {
          return SectionWidget(
            key: Key(element.elementPath!),
            element: element,
          );
        } else if (element is RepeatSection) {
          return RepeatTableSliver(
            key: Key('${element.elementPath!}_RepeatTable'),
            repeatInstance: element,
          );
        } else if (element is FieldInstance) {
          final key = formInstance.fieldKeysRegistery
              .getOrCreateKey(element.elementPath!);
          return FieldWidget(
            key: key,
            element: element,
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }).toList();
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: 500),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 16),
                    sliver: MultiSliver(children: buildSlivers()),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      onCancel();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      onSave();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Usage example:
///
/// ```dart
/// void _openFormDialog(BuildContext context, WidgetRef ref) {
///   final formInstance = ref.read(
///     formInstanceProvider(formMetadata: /* metadata here */)
///   ).requireValue;
///
///   showDialog(
///     context: context,
///     builder: (_) => SliverFormDialog(
///       formInstance: formInstance,
///       onCancel: () => print('cancelled'),
///       onSave: () => print('saved: \${formInstance.form.value}'),
///     ),
///   );
/// }
///
